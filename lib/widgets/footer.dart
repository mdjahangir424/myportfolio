
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/social_data.dart';

class PortfolioFooter extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const PortfolioFooter({
    super.key,
    required this.onNavigate,
  });

  static const Color _accentColor = Color(0xFF3B82F6);

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  Widget _footerHeading(
    String title,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _footerLink(
    String title,
    Color textColor, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _footerColumn({
    required String title,
    required List<Widget> children,
    required Color headingColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _footerHeading(title, headingColor),
        ...children,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark
        ? const Color(0xFF0B1120)
        : const Color(0xFFF1F5F9);

    final headingColor = isDark
        ? Colors.white
        : const Color(0xFF0F172A);

    final textColor = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF475569);

    final dividerColor = isDark
        ? const Color(0xFF263247)
        : const Color(0xFFCBD5E1);

    final quickLinks = [
      'Home',
      'About',
      'Skills',
      'Services',
      'Projects',
      'Automation',
      'Contact',
    ];

    final expertise = [
      'Flutter Development',
      'Dart Programming',
      'Firebase',
      'AI Agent Development',
    ];

    final services = [
      'App Development',
      'AI Automation',
      'Workflow Automation',
    ];

    final socialLinks = socialData.where(
      (item) =>
          item.name != 'Email' && item.name != 'WhatsApp',
    );

    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 55,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  final itemWidth = width >= 950
                      ? (width - 72) / 4
                      : width >= 600
                          ? (width - 24) / 2
                          : width;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 35,
                    children: [
                      SizedBox(
                        width: itemWidth,
                        child: _footerColumn(
                          title: 'Quick Links',
                          headingColor: headingColor,
                          children: quickLinks.map((item) {
                            return _footerLink(
                              item,
                              textColor,
                              onTap: () => onNavigate(item),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(
                        width: itemWidth,
                        child: _footerColumn(
                          title: 'My Expertise',
                          headingColor: headingColor,
                          children: expertise.map((item) {
                            return _footerLink(
                              item,
                              textColor,
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(
                        width: itemWidth,
                        child: _footerColumn(
                          title: 'Services',
                          headingColor: headingColor,
                          children: services.map((item) {
                            return _footerLink(
                              item,
                              textColor,
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(
                        width: itemWidth,
                        child: _footerColumn(
                          title: 'Connect With Me',
                          headingColor: headingColor,
                          children: socialLinks.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 12,
                              ),
                              child: InkWell(
                                onTap: () => _openUrl(item.url),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      item.icon,
                                      size: 18,
                                      color: _accentColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 40),

              Divider(
                color: dividerColor,
                thickness: 1,
              ),

              const SizedBox(height: 25),

              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let's Work Together",
                        style: TextStyle(
                          color: headingColor,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        'Have a project in mind? Get in touch with me.',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => _openUrl(
                          'mailto:mdjahangir424@outlook.com',
                        ),
                        icon: const Icon(Icons.email_outlined),
                        label: const Text('Email Me'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isDark
                              ? Colors.white
                              : const Color(0xFF1E293B),
                          side: const BorderSide(
                            color: _accentColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                        ),
                      ),

                      ElevatedButton.icon(
                        onPressed: () => _openUrl(
                          'https://wa.me/8801778600028',
                        ),
                        icon: const Icon(Icons.chat_outlined),
                        label: const Text('WhatsApp'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Divider(
                color: dividerColor,
                thickness: 1,
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  '© 2026 Md Jahangir Alam. All Rights Reserved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
