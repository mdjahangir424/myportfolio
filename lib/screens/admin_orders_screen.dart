import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  static const _adminUid = 'GkTwGpQOofgtunEYI1WjjPgmKvE3';
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController(text: 'mdjahangiralam2528@gmail.com');
  final _password = TextEditingController();
  User? _admin;
  bool _checking = true;
  bool _busy = false;
  String? _error;
  String _filter = 'all';
  final Set<String> _updating = {};

  @override
  void initState() {
    super.initState();
    _restoreSession();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<bool> _isAuthorized(User user) async {
    if (user.uid != _adminUid || user.isAnonymous) return false;
    // Firestore Rules validate the active admin allow-list before orders
    // can be read or changed. Client reads of /admins are intentionally denied.
    return true;
  }

  Future<void> _restoreSession() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.isAnonymous && user.uid == _adminUid) {
      try {
        if (await _isAuthorized(user) && mounted) {
          setState(() => _admin = user);
        }
      } catch (error) {
        debugPrint('Admin session verification failed: $error');
      }
    }
    if (mounted) setState(() => _checking = false);
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _busy = true; _error = null; });
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text,
      );
      final user = result.user;
      if (user == null || !await _isAuthorized(user)) {
        await FirebaseAuth.instance.signOut();
        throw StateError('এই অ্যাকাউন্টটি অনুমোদিত অ্যাডমিন অ্যাকাউন্ট নয়।');
      }
      if (mounted) setState(() => _admin = user);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = switch (e.code) {
          'invalid-credential' || 'wrong-password' || 'user-not-found' =>
            'ইমেইল অথবা পাসওয়ার্ড সঠিক নয়।',
          'operation-not-allowed' =>
            'Firebase Authentication-এ Email/Password provider Enable করুন।',
          'too-many-requests' => 'অনেকবার চেষ্টা হয়েছে। কিছুক্ষণ পর আবার চেষ্টা করুন।',
          _ => 'Login ব্যর্থ: ' + (e.message ?? e.code),
        };
      });
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) setState(() { _admin = null; _password.clear(); });
  }

  int _amount(dynamic value) => value is num ? value ~/ 100 : 0;

  String _date(dynamic value) {
    if (value is! Timestamp) return 'সময় পাওয়া যায়নি';
    final d = value.toDate().toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return two(d.day) + '/' + two(d.month) + '/' + d.year.toString() +
        ' ' + two(d.hour) + ':' + two(d.minute);
  }

  Future<void> _changeStatus(
    QueryDocumentSnapshot<Map<String, dynamic>> order,
    String status,
  ) async {
    final data = order.data();
    final approve = status == 'approved';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(approve ? 'অর্ডার Approve করবেন?' : 'অর্ডার Reject করবেন?'),
        content: Text(
          'Customer: ' + (data['customerName']?.toString() ?? 'N/A') +
          '\nAmount: ৳' + _amount(data['amount']).toString() +
          '\nTrxID: ' + (data['transactionId']?.toString() ?? 'N/A') +
          '\n\nপেমেন্ট যাচাই করার পরেই Approve করুন।',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('বাতিল'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(approve ? 'Approve' : 'Reject'),
          ),
        ],
      ),
    );
    if (confirmed != true || _admin == null) return;
    setState(() => _updating.add(order.id));
    try {
      await FirebaseFirestore.instance.collection('orders').doc(order.id).update({
        'status': status,
        'reviewedAt': FieldValue.serverTimestamp(),
        'reviewedBy': _admin!.uid,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(approve ? 'অর্ডার Approved হয়েছে।' : 'অর্ডার Rejected হয়েছে।')),
        );
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('আপডেট ব্যর্থ: ' + e.code)),
        );
      }
    } finally {
      if (mounted) setState(() => _updating.remove(order.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) return const Center(child: CircularProgressIndicator());
    return _admin == null ? _loginView(context) : _dashboard(context);
  }

  Widget _loginView(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.admin_panel_settings_rounded, size: 54, color: colors.primary),
                    const SizedBox(height: 14),
                    Text('Learning Store Admin',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('অনুমোদিত Admin account দিয়ে Login করুন।', textAlign: TextAlign.center),
                    const SizedBox(height: 22),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Admin Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || !v.contains('@') ? 'সঠিক ইমেইল লিখুন' : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      onFieldSubmitted: (_) => _busy ? null : _login(),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'পাসওয়ার্ড লিখুন' : null,
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 12),
                      Text(_error!, style: TextStyle(color: colors.error)),
                    ],
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      onPressed: _busy ? null : _login,
                      icon: _busy
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.login_rounded),
                      label: Text(_busy ? 'অপেক্ষা করুন...' : 'Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dashboard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final query = FirebaseFirestore.instance.collection('orders')
        .orderBy('createdAt', descending: true).limit(100);
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('অর্ডার লোড করা যায়নি। Firestore Rules ও Admin UID যাচাই করুন।\n' + snapshot.error.toString(),
                textAlign: TextAlign.center),
            ),
          );
        }
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final orders = snapshot.data!.docs;
        int count(String status) => orders.where((o) => o.data()['status'] == status).length;
        final visible = orders.where((o) =>
          _filter == 'all' || o.data()['status'] == _filter).toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order Management', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                          Text('সর্বশেষ ' + orders.length.toString() + 'টি অর্ডার'),
                        ],
                      )),
                      IconButton(tooltip: 'Refresh', onPressed: () => setState(() {}), icon: const Icon(Icons.refresh)),
                      OutlinedButton.icon(onPressed: _logout, icon: const Icon(Icons.logout, size: 18), label: const Text('Logout')),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Wrap(spacing: 10, runSpacing: 10, children: [
                    _summary(context, 'Total', orders.length, Icons.receipt_long, colors.primary),
                    _summary(context, 'Pending', count('pending'), Icons.pending_actions, Colors.orange),
                    _summary(context, 'Approved', count('approved'), Icons.check_circle_outline, Colors.green),
                    _summary(context, 'Rejected', count('rejected'), Icons.cancel_outlined, colors.error),
                  ]),
                  const SizedBox(height: 22),
                  Wrap(spacing: 8, children: [
                    _filterChip('all', 'সব'),
                    _filterChip('pending', 'Pending'),
                    _filterChip('approved', 'Approved'),
                    _filterChip('rejected', 'Rejected'),
                  ]),
                  const SizedBox(height: 14),
                  if (visible.isEmpty)
                    const Card(child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(child: Text('এই ক্যাটাগরিতে কোনো অর্ডার নেই।')),
                    ))
                  else
                    ...visible.map((order) => _orderCard(context, order)),
                  const SizedBox(height: 12),
                  Text('পেমেন্ট যাচাই না করে কোনো অর্ডার Approve করবেন না।',
                    style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _summary(BuildContext context, String label, int value, IconData icon, Color color) {
    return SizedBox(
      width: 245,
      child: Card(child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label),
            Text(value.toString(), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          ]),
        ]),
      )),
    );
  }

  Widget _filterChip(String value, String label) => ChoiceChip(
    label: Text(label),
    selected: _filter == value,
    onSelected: (_) => setState(() => _filter = value),
  );

  Widget _orderCard(BuildContext context, QueryDocumentSnapshot<Map<String, dynamic>> order) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final data = order.data();
    final status = (data['status'] ?? 'pending').toString();
    final statusColor = status == 'approved'
        ? Colors.green
        : status == 'rejected' ? colors.error : Colors.orange.shade800;
    final busy = _updating.contains(order.id);

    Widget detail(String label, String value) => Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 128, child: Text(label, style: theme.textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant))),
        Expanded(child: SelectableText(value)),
      ]),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Text(data['productTitle']?.toString() ?? 'Unknown product',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              Chip(
                label: Text(status.toUpperCase()),
                backgroundColor: statusColor.withValues(alpha: 0.12),
                labelStyle: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11),
                side: BorderSide(color: statusColor.withValues(alpha: 0.3)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          detail('Order ID', order.id),
          detail('Customer', data['customerName']?.toString() ?? 'N/A'),
          detail('Customer phone', data['customerPhone']?.toString() ?? 'N/A'),
          detail('Amount', '৳' + _amount(data['amount']).toString()),
          detail('Payment method', data['paymentMethod']?.toString() ?? 'N/A'),
          detail('Sender phone', data['senderPhone']?.toString() ?? 'N/A'),
          detail('Transaction ID', data['transactionId']?.toString() ?? 'N/A'),
          detail('Submitted', _date(data['createdAt'])),
          if (status == 'pending') ...[
            const SizedBox(height: 10),
            Wrap(spacing: 10, runSpacing: 8, children: [
              FilledButton.icon(
                onPressed: busy ? null : () => _changeStatus(order, 'approved'),
                icon: const Icon(Icons.check, size: 18),
                label: const Text('Approve payment'),
              ),
              OutlinedButton.icon(
                onPressed: busy ? null : () => _changeStatus(order, 'rejected'),
                icon: const Icon(Icons.close, size: 18),
                label: const Text('Reject'),
                style: OutlinedButton.styleFrom(foregroundColor: colors.error),
              ),
              if (busy) const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2)),
            ]),
          ],
        ]),
      ),
    );
  }
}
