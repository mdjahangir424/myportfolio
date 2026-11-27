import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/digital_product.dart';

class BookOrderDialog extends StatefulWidget {
  final DigitalProduct product;

  const BookOrderDialog({super.key, required this.product});

  @override
  State<BookOrderDialog> createState() => _BookOrderDialogState();
}

class _BookOrderDialogState extends State<BookOrderDialog> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _transaction = TextEditingController();
  String _method = 'bkash';
  bool _submitting = false;
  String? _error;

  static const _accounts = <String, String>{
    'bkash': '01778600028',
    'nagad': '01778600028',
    'rocket': '017786000285',
  };

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _transaction.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _error = null;
    });

    try {
      final credential = await FirebaseAuth.instance.signInAnonymously();
      if (credential.user == null) {
        throw StateError('Could not start a secure order session.');
      }

      final ref = await FirebaseFirestore.instance.collection('orders').add({
        'productId': widget.product.id,
        'productTitle': widget.product.title,
        'amount': widget.product.priceMinor,
        'currency': widget.product.currency,
        'customerName': _name.text.trim(),
        'customerPhone': _phone.text.trim(),
        'paymentMethod': _method,
        'transactionId': _transaction.text.trim(),
        'senderPhone': _phone.text.trim(),
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      Navigator.of(context).pop(ref.id);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = 'অর্ডার জমা হয়নি। Firebase Authentication ও Firestore '
            'সেটআপ এবং Rules প্রকাশিত আছে কি না যাচাই করুন।';
      });
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final amount = widget.product.priceMinor ~/ 100;

    return AlertDialog(
      title: const Text('বই অর্ডার করুন'),
      content: SizedBox(
        width: 460,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(widget.product.title,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('মোট মূল্য: ৳$amount',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(color: theme.colorScheme.primary)),
                const SizedBox(height: 18),
                const Text('১. নিচের নম্বরে Send Money করুন'),
                const SizedBox(height: 10),
                _PaymentNumber(
                    label: 'bKash Personal',
                    number: _accounts['bkash']!),
                _PaymentNumber(
                    label: 'Nagad Personal',
                    number: _accounts['nagad']!),
                _PaymentNumber(
                    label: 'Rocket Personal',
                    number: _accounts['rocket']!),
                const SizedBox(height: 12),
                const Text('২. পেমেন্টের তথ্য দিন'),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'আপনার নাম',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().length < 2)
                      ? 'সঠিক নাম লিখুন'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'যে নম্বর থেকে টাকা পাঠিয়েছেন',
                    hintText: '01XXXXXXXXX',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null ||
                          !RegExp(r'^01[3-9][0-9]{8}$').hasMatch(v.trim()))
                      ? 'সঠিক বাংলাদেশি মোবাইল নম্বর লিখুন'
                      : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _method,
                  decoration: const InputDecoration(
                    labelText: 'পেমেন্ট মাধ্যম',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'bkash', child: Text('bKash')),
                    DropdownMenuItem(value: 'nagad', child: Text('Nagad')),
                    DropdownMenuItem(value: 'rocket', child: Text('Rocket')),
                  ],
                  onChanged: _submitting
                      ? null
                      : (value) => setState(() => _method = value ?? 'bkash'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _transaction,
                  decoration: const InputDecoration(
                    labelText: 'Transaction ID (TrxID)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().length < 5)
                      ? 'সঠিক Transaction ID লিখুন'
                      : null,
                ),
                const SizedBox(height: 12),
                Text(
                  'অর্ডার জমা হলে স্ট্যাটাস Pending থাকবে। পেমেন্ট যাচাইয়ের '
                  'পর আপনাকে ডাউনলোডের নির্দেশনা দেওয়া হবে।',
                  style: theme.textTheme.bodySmall,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 10),
                  Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: const Text('বাতিল'),
        ),
        FilledButton(
          onPressed: _submitting ? null : _submit,
          child: _submitting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('অর্ডার জমা দিন'),
        ),
      ],
    );
  }
}

class _PaymentNumber extends StatelessWidget {
  final String label;
  final String number;

  const _PaymentNumber({required this.label, required this.number});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 7),
      child: ListTile(
        dense: true,
        title: Text(label),
        subtitle: SelectableText(number),
        trailing: IconButton(
          tooltip: 'নম্বর কপি করুন',
          icon: const Icon(Icons.copy_rounded),
          onPressed: () {
            // Clipboard is available through Flutter's standard services.
            // ignore: deprecated_member_use
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$label: $number')),
            );
          },
        ),
      ),
    );
  }
}
