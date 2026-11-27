import 'package:flutter/material.dart';

import '../widgets/section_title.dart';
import '../widgets/shared_screen_layout.dart';

class CoursesScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const CoursesScreen({
    super.key,
    required this.onNavigate,
  });

  static const _categories = <_StoreCategory>[
    _StoreCategory(
      title: 'Online Courses',
      subtitle: 'Step-by-step video lessons and practical learning paths.',
      icon: Icons.play_circle_outline_rounded,
      accent: Color(0xFF2563EB),
      tag: 'VIDEO LEARNING',
    ),
    _StoreCategory(
      title: 'PDF Books & eBooks',
      subtitle: 'Guides, notes, and downloadable learning materials.',
      icon: Icons.menu_book_rounded,
      accent: Color(0xFF0D9488),
      tag: 'DIGITAL BOOKS',
    ),
    _StoreCategory(
      title: 'Digital Products',
      subtitle: 'Useful templates, code resources, and developer tools.',
      icon: Icons.widgets_outlined,
      accent: Color(0xFF8B5CF6),
      tag: 'READY-TO-USE RESOURCES',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SharedScreenLayout(
      onNavigate: onNavigate,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionTitle(
                title: 'Courses & Digital Products',
                subtitle:
                    'Learn practical skills with courses, digital books, and '
                    'resources created for builders and developers.',
              ),
              const SizedBox(height: 36),
              _buildHero(context),
              const SizedBox(height: 46),
              Text(
                'Explore Learning Categories',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Choose the type of resource you are interested in.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 22),
              LayoutBuilder(
                builder: (context, constraints) {
                  final count = constraints.maxWidth >= 850
                      ? 3
                      : constraints.maxWidth >= 560
                          ? 2
                          : 1;
                  const spacing = 18.0;
                  final itemWidth =
                      (constraints.maxWidth - spacing * (count - 1)) / count;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: _categories
                        .map(
                          (category) => SizedBox(
                            width: itemWidth,
                            child: _CategoryCard(category: category),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 46),
              _buildComingSoon(context),
              const SizedBox(height: 28),
              _buildContactBanner(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF172554), Color(0xFF172033), Color(0xFF1E1B4B)]
              : const [Color(0xFFEFF6FF), Color(0xFFF1F5FF), Color(0xFFF5F3FF)],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: colors.primary.withValues(alpha: isDark ? 0.28 : 0.12),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 620;
          final textContent = Column(
            crossAxisAlignment:
                compact ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'LEARN  •  BUILD  •  GROW',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Build Skills.\nCreate More.',
                textAlign: compact ? TextAlign.center : TextAlign.start,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.16,
                  color: isDark ? Colors.white : const Color(0xFF172554),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Practical learning resources for Flutter, Firebase, '
                'software development, and AI automation.',
                textAlign: compact ? TextAlign.center : TextAlign.start,
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.7,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.78)
                      : const Color(0xFF475569),
                ),
              ),
            ],
          );

          final illustration = Container(
            height: compact ? 112 : 170,
            width: compact ? 112 : 170,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: isDark ? 0.18 : 0.10),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.school_rounded,
              size: compact ? 58 : 88,
              color: colors.primary,
            ),
          );

          if (compact) {
            return Column(
              children: [
                illustration,
                const SizedBox(height: 24),
                textContent,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: textContent),
              const SizedBox(width: 28),
              illustration,
            ],
          );
        },
      ),
    );
  }

  Widget _buildComingSoon(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome_outlined, color: colors.primary, size: 26),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Learning Store Is Being Prepared',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Course lessons, book details, product previews, and pricing '
                  'will appear here as each resource is published. No sample '
                  'products or prices are displayed as real offers.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.65,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactBanner(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      decoration: BoxDecoration(
        color: colors.primary.withValues(
          alpha: theme.brightness == Brightness.dark ? 0.12 : 0.06,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 560;
          final message = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Looking for a specific learning resource?',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Get in touch to discuss your learning needs.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          );

          final button = OutlinedButton.icon(
            onPressed: () => onNavigate('Contact'),
            icon: const Icon(Icons.mail_outline_rounded, size: 18),
            label: const Text('Contact Me'),
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [message, const SizedBox(height: 16), button],
            );
          }

          return Row(
            children: [
              Expanded(child: message),
              const SizedBox(width: 16),
              button,
            ],
          );
        },
      ),
    );
  }
}

class _StoreCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final String tag;

  const _StoreCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.tag,
  });
}

class _CategoryCard extends StatelessWidget {
  final _StoreCategory category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      constraints: const BoxConstraints(minHeight: 218),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.10 : 0.035,
            ),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: category.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(category.icon, color: category.accent, size: 27),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'COMING SOON',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.35,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            category.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.55,
            ),
          ),
          const Spacer(),
          Text(
            category.tag,
            style: theme.textTheme.labelSmall?.copyWith(
              color: category.accent,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
