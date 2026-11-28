import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class BookDownloadSection extends StatefulWidget {
  const BookDownloadSection({super.key});

  @override
  State<BookDownloadSection> createState() => _BookDownloadSectionState();
}

class _BookDownloadSectionState extends State<BookDownloadSection> {
  static const _functionUrl =
      'https://pnvvalcrqftumcmtzuav.supabase.co/functions/v1/download-book';
  static const _publishableKey =
      'sb_publishable_TMV8q7g38sCLVPAfcBjshQ_iBuDulAo';

  final _orderIdController = TextEditingController();
  bool _checking = false;
  String? _message;
  bool _hasError = false;
  String? _downloadUrl;

  @override
  void dispose() {
    _orderIdController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _decodeResponse(String body) {
    try {
      final value = jsonDecode(body);
      if (value is Map<String, dynamic>) return value;
    } catch (_) {
      // The function may return a non-JSON gateway error.
    }
    return <String, dynamic>{};
  }

  String _friendlyError(String error) {
    switch (error) {
      case 'Your order is not approved yet':
        return 'আপনার অর্ডার এখনো Approved হয়নি। পেমেন্ট যাচাইয়ের পর আবার চেষ্টা করুন।';
      case 'This order does not belong to you':
      case 'Order access denied':
        return 'এই Order ID বর্তমান ব্রাউজারের Firebase সেশনের নয়। অর্ডার করা একই ব্রাউজার ব্যবহার করুন।';
      case 'Order not found':
        return 'এই Order ID পাওয়া যায়নি। আইডিটি আবার যাচাই করুন।';
      case 'Firebase login required':
        return 'অর্ডার করার সময় ব্যবহৃত Firebase সেশন পাওয়া যায়নি। একই ব্রাউজারে আবার চেষ্টা করুন।';
      default:
        return error.isEmpty ? 'ডাউনলোড লিংক তৈরি করা যায়নি। পরে আবার চেষ্টা করুন।' : error;
    }
  }

  Future<void> _checkOrder() async {
    final orderId = _orderIdController.text.trim();
    if (orderId.isEmpty) {
      setState(() {
        _message = 'আপনার Order ID লিখুন।';
        _hasError = true;
        _downloadUrl = null;
      });
      return;
    }

    setState(() {
      _checking = true;
      _message = null;
      _downloadUrl = null;
      _hasError = false;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw StateError(
          'অর্ডার করার সময় ব্যবহৃত Firebase সেশন এই ব্রাউজারে পাওয়া যায়নি।',
        );
      }

      final token = await user.getIdToken(true);
      if (token == null || token.isEmpty) {
        throw StateError('Firebase ID Token পাওয়া যায়নি। আবার Login করুন।');
      }

      final response = await http.post(
        Uri.parse(_functionUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'apikey': _publishableKey,
        },
        body: jsonEncode({'orderId': orderId}),
      );

      final payload = _decodeResponse(response.body);
      if (response.statusCode != 200) {
        final error = payload['error']?.toString() ?? '';
        setState(() {
          _message = _friendlyError(error);
          _hasError = true;
        });
        return;
      }

      final value = payload['downloadUrl'];
      final uri = value is String ? Uri.tryParse(value) : null;
      if (uri == null ||
          uri.scheme != 'https' ||
          uri.host != 'pnvvalcrqftumcmtzuav.supabase.co') {
        throw StateError('সার্ভার থেকে নিরাপদ Download URL পাওয়া যায়নি।');
      }

      setState(() {
        _downloadUrl = uri.toString();
        _message = 'অর্ডার Approved হয়েছে। নিচের বাটনে ক্লিক করে PDF ডাউনলোড করুন। লিংকটি ২ মিনিটের জন্য কার্যকর থাকবে।';
        _hasError = false;
      });
    } catch (error) {
      setState(() {
        _message = error is StateError
            ? error.message
            : 'সংযোগে সমস্যা হয়েছে। আবার চেষ্টা করুন।';
        _hasError = true;
      });
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  Future<void> _openDownload() async {
    final value = _downloadUrl;
    if (value == null) return;

    final opened = await launchUrl(
      Uri.parse(value),
      mode: LaunchMode.externalApplication,
    );

    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Download link খোলা যায়নি। আবার চেষ্টা করুন।')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.download_for_offline_outlined,
                  color: colors.primary, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'আপনার কেনা PDF ডাউনলোড করুন',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'অর্ডার জমা দেওয়ার পর পাওয়া Order ID লিখুন। পেমেন্ট Approved হলে ডাউনলোড লিংক তৈরি হবে।',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _orderIdController,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _checking ? null : _checkOrder(),
            decoration: const InputDecoration(
              labelText: 'Order ID',
              hintText: 'আপনার Order ID এখানে লিখুন',
              prefixIcon: Icon(Icons.receipt_long_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _checking ? null : _checkOrder,
              icon: _checking
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.verified_outlined),
              label: Text(_checking ? 'যাচাই হচ্ছে...' : 'অর্ডার যাচাই করুন'),
            ),
          ),
          if (_message != null) ...[
            const SizedBox(height: 14),
            Text(
              _message!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: _hasError ? colors.error : colors.primary,
                height: 1.55,
              ),
            ),
          ],
          if (_downloadUrl != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _openDownload,
                icon: const Icon(Icons.picture_as_pdf_outlined),
                label: const Text('Download PDF'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
