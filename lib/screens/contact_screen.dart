import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/social_data.dart';
import '../widgets/footer.dart';
import '../widgets/section_title.dart';

class ContactScreen extends StatefulWidget {
  final ValueChanged<String> onNavigate;

  const ContactScreen({super.key, required this.onNavigate});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  static const _contactEmail = 'mdjahangir424@outlook.com';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.tryParse(url.trim());
    if (uri == null || !['https', 'http', 'mailto'].contains(uri.scheme)) {
      return;
    }
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && mounted) _showMessage('Could not open this link.');
    } catch (error) {
      debugPrint('Could not open link: $error');
      if (mounted) _showMessage('Unable to open this link.');
    }
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSending = true);

    final subject = _subjectController.text.trim().isEmpty
        ? 'Portfolio Contact - ' + _nameController.text.trim()
        : _subjectController.text.trim();
    final body = 'Name: ' + _nameController.text.trim() + '\n' +
        'Email: ' + _emailController.text.trim() + '\n\n' +
        'Message:\n' + _messageController.text.trim();
    final uri = Uri(
      scheme: 'mailto',
      path: _contactEmail,
      queryParameters: {'subject': subject, 'body': body},
    );

    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (mounted) {
        _showMessage(
          opened
              ? 'Your email app is ready. Please review and send your message.'
              : 'Could not open your email app. Please email $_contactEmail directly.',
        );
      }
    } catch (error) {
      debugPrint('Could not open email app: $error');
      if (mounted) _showMessage('Please email $_contactEmail directly.');
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    const SectionTitle(
                      title: 'Get In Touch',
                      subtitle:
                          'Have a project in mind? Let’s discuss how I can help.',
                    ),
                    const SizedBox(height: 42),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        const gap = 24.0;
                        if (constraints.maxWidth < 850) {
                          return Column(
                            children: [
                              _buildIntroCard(context),
                              const SizedBox(height: gap),
                              _buildFormCard(context),
                            ],
                          );
                        }
                        return IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: _buildIntroCard(context)),
                              const SizedBox(width: gap),
                              Expanded(child: _buildFormCard(context)),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildSocialSection(context),
                  ],
                ),
              ),
            ),
          ),
          PortfolioFooter(onNavigate: widget.onNavigate),
        ],
      ),
    );
  }

  Widget _buildIntroCard(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return _cardShell(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [colors.primary, colors.secondary]),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Icon(Icons.handshake_outlined, color: colors.onPrimary, size: 30),
          ),
          const SizedBox(height: 22),
          Text(
            'Let’s Work Together',
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'I am available for Flutter development, AI agent development, '
            'and business automation projects. Let’s connect and build '
            'something meaningful.',
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.8),
          ),
          const SizedBox(height: 28),
          _contactItem(context, Icons.person_outline, 'Name', 'Md Jahangir Alam'),
          _contactItem(
            context,
            Icons.work_outline,
            'Profession',
            'Flutter Developer & AI Automation Specialist',
          ),
          _contactItem(context, Icons.email_outlined, 'Email Address', _contactEmail),
          const SizedBox(height: 8),
          Divider(color: theme.dividerColor.withValues(alpha: 0.4)),
          const SizedBox(height: 20),

        ],
      ),
    );
  }

  Widget _buildSocialSection(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return _cardShell(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connect With Me',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Find me on social media or send me a message.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final count = constraints.maxWidth >= 760
                  ? 4
                  : constraints.maxWidth >= 480
                      ? 3
                      : constraints.maxWidth >= 300
                          ? 2
                          : 1;
              const spacing = 12.0;
              final itemWidth =
                  (constraints.maxWidth - spacing * (count - 1)) / count;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: socialData.map((social) {
                  return SizedBox(
                    width: itemWidth,
                    child: Material(
                      color: colors.primary.withValues(
                        alpha: isDark ? 0.12 : 0.055,
                      ),
                      borderRadius: BorderRadius.circular(13),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(13),
                        onTap: () => _openLink(social.url),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 15,
                          ),
                          child: Row(
                            children: [
                              Icon(social.icon, color: colors.primary, size: 21),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  social.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.open_in_new_rounded,
                                size: 14,
                                color: colors.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return _cardShell(
      context,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Me a Message',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Tell me a little about your project. I’ll get back to you as soon as possible.',
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.6,
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 28),
            _formField(
              context,
              controller: _nameController,
              label: 'Your Name',
              hint: 'Enter your full name',
              icon: Icons.person_outline_rounded,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Please enter your name.'
                  : null,
            ),
            const SizedBox(height: 18),
            _formField(
              context,
              controller: _emailController,
              label: 'Email Address',
              hint: 'you@example.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                final email = value?.trim() ?? '';
                if (email.isEmpty) return 'Please enter your email address.';
                if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            _formField(
              context,
              controller: _subjectController,
              label: 'Subject',
              hint: 'What would you like to discuss?',
              icon: Icons.subject_rounded,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Please enter a subject.'
                  : null,
            ),
            const SizedBox(height: 18),
            _formField(
              context,
              controller: _messageController,
              label: 'Your Message',
              hint: 'Write your message here...',
              icon: Icons.chat_bubble_outline_rounded,
              maxLines: 6,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Please write a message.'
                  : value.trim().length < 10
                      ? 'Please write at least 10 characters.'
                      : null,
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isSending ? null : _sendMessage,
                icon: _isSending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_rounded, size: 18),
                label: Text(_isSending ? 'Preparing...' : 'Send Message'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Your message will open in your email app so you can review and send it.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardShell(BuildContext context, {required Widget child}) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colors.primary.withValues(alpha: isDark ? 0.22 : 0.10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.14 : 0.045),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _formField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 9),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: maxLines == 1 ? Icon(icon, size: 20) : null,
            alignLabelWithHint: maxLines > 1,
            filled: true,
            fillColor: colors.surfaceContainerHighest.withValues(alpha: 0.42),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: colors.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: colors.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: colors.primary, width: 1.6),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: colors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: colors.error, width: 1.6),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contactItem(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.textTheme.labelMedium),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
