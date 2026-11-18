
import 'package:flutter/material.dart';

import '../data/services_data.dart';
import '../widgets/section_title.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SectionTitle(
                title: 'My Services',
                subtitle:
                    'Professional development and automation solutions '
                    'to help businesses grow.',
              ),

              const SizedBox(height: 42),

              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  final crossAxisCount = width >= 900
                      ? 3
                      : width >= 600
                          ? 2
                          : 1;

                  const spacing = 22.0;

                  final cardWidth = crossAxisCount == 1
                      ? width
                      : (width -
                              spacing * (crossAxisCount - 1)) /
                          crossAxisCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: servicesData.map((service) {
                      return SizedBox(
                        width: cardWidth,
                        child: Container(
                          padding: const EdgeInsets.all(26),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: colors.primary.withValues(
                                alpha: isDark ? 0.22 : 0.10,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: isDark ? 0.12 : 0.045,
                                ),
                                blurRadius: 22,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 62,
                                width: 62,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      colors.primary,
                                      colors.secondary,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(18),
                                ),
                                child: Icon(
                                  service.icon,
                                  color: colors.onPrimary,
                                  size: 30,
                                ),
                              ),

                              const SizedBox(height: 22),

                              Text(
                                service.title,
                                style: theme.textTheme.titleLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                service.description,
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(
                                  height: 1.7,
                                  color: theme.textTheme.bodyMedium
                                      ?.color
                                      ?.withValues(alpha: 0.75),
                                ),
                              ),

                              const SizedBox(height: 22),

                              Divider(
                                color: theme.dividerColor.withValues(
                                  alpha: 0.35,
                                ),
                              ),

                              const SizedBox(height: 14),

                              Text(
                                'WHAT’S INCLUDED',
                                style: theme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                ),
                              ),

                              const SizedBox(height: 14),

                              ...service.features.map((feature) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        size: 19,
                                        color: colors.primary,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
