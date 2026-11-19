
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/section_title.dart';
import '../data/social_data.dart';
import '../widgets/footer.dart';

class ContactScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const ContactScreen({
    super.key,
    required this.onNavigate,
  });

  Future<void> _openLink(
    BuildContext context,
    String url,
  ) async {
    final uri = Uri.tryParse(url.trim());

    if (uri == null ||
        !['https', 'http', 'mailto'].contains(uri.scheme)) {
      return;
    }

    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open this link.'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Could not open link: $e');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to open this link.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 40,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  children: [
                    const SectionTitle(
                      title: 'Get In Touch',
                      subtitle:
                          'Have a project in mind? Let’s discuss how I can help.',
                    ),

                    const SizedBox(height: 42),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: colors.primary.withValues(
                            alpha: isDark ? 0.22 : 0.10,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: isDark ? 0.14 : 0.045,
                            ),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 58,
                                width: 58,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      colors.primary,
                                      colors.secondary,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Icon(
                                  Icons.handshake_outlined,
                                  color: colors.onPrimary,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Let’s Work Together',
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Text(
                            'I am available for Flutter development, AI agent '
                            'development, and business automation projects. '
                            'Let’s connect and build something meaningful.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.8,
                            ),
                          ),

                          const SizedBox(height: 28),

                          _contactItem(
                            context,
                            Icons.person_outline,
                            'Name',
                            'Md Jahangir Alam',
                          ),

                          _contactItem(
                            context,
                            Icons.work_outline,
                            'Profession',
                            'Flutter Developer & AI Automation Specialist',
                          ),

                          _contactItem(
                            context,
                            Icons.email_outlined,
                            'Email Address',
                            'mdjahangir424@outlook.com',
                          ),

                          const SizedBox(height: 22),

                          Divider(
                            color: theme.dividerColor.withValues(
                              alpha: 0.4,
                            ),
                          ),

                          const SizedBox(height: 22),

                          Text(
                            'Connect With Me',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Find me on social media or send me a message.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.textTheme.bodySmall?.color
                                  ?.withValues(alpha: 0.7),
                            ),
                          ),

                          const SizedBox(height: 22),

                          LayoutBuilder(
                            builder: (context, constraints) {
                              final width = constraints.maxWidth;

                              final count = width >= 650
                                  ? 3
                                  : width >= 400
                                      ? 2
                                      : 1;

                              const spacing = 12.0;

                              final cardWidth = count == 1
                                  ? width
                                  : (width - spacing * (count - 1)) /
                                      count;

                              return Wrap(
                                spacing: spacing,
                                runSpacing: spacing,
                                children: socialData.map((social) {
                                  return SizedBox(
                                    width: cardWidth,
                                    child: Material(
                                      color: colors.primary.withValues(
                                        alpha: isDark ? 0.12 : 0.055,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(15),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        onTap: () => _openLink(
                                          context,
                                          social.url,
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 17,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                social.icon,
                                                color: colors.primary,
                                                size: 24,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  social.name,
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.open_in_new_rounded,
                                                size: 16,
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
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Shared Footer
          PortfolioFooter(
            onNavigate: onNavigate,
          ),
        ],
      ),
    );
  }

  Widget _contactItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelMedium,
                ),
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
