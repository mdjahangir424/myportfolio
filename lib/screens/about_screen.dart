

import 'package:flutter/material.dart';

import '../widgets/section_title.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 70,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SectionTitle(
                title: 'About Me',
                subtitle:
                    'Get to know more about my professional journey.',
              ),

              const SizedBox(height: 50),

              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 700;

                  final introduction = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello! I am Md Jahangir Alam.',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.onSurface,
                            ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'I am focused on Flutter application development, '
                        'AI agent development and workflow automation. '
                        'I enjoy exploring modern technologies and '
                        'building practical digital solutions.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.9,
                          color: colors.onSurface.withValues(
                            alpha: 0.75,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'My goal is to develop reliable, user-friendly '
                        'applications and intelligent automation '
                        'solutions that help businesses and individuals.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.9,
                          color: colors.onSurface.withValues(
                            alpha: 0.75,
                          ),
                        ),
                      ),
                    ],
                  );

                  final profile = Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colors.primary.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: colors.primary,
                          child: const Text(
                            'JA',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Md Jahangir Alam',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Flutter Developer & AI Automation Specialist',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.onSurface.withValues(
                              alpha: 0.7,
                            ),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );

                  if (isMobile) {
                    return Column(
                      children: [
                        profile,
                        const SizedBox(height: 35),
                        introduction,
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 4, child: profile),
                      const SizedBox(width: 50),
                      Expanded(flex: 6, child: introduction),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
