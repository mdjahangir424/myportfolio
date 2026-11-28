import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/digital_products_data.dart';
import '../models/digital_product.dart';
import '../widgets/section_title.dart';
import '../widgets/book_order_dialog.dart';
import '../widgets/book_download_section.dart';
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
              const SizedBox(height: 42),
              _buildBookCatalog(context),
              const SizedBox(height: 22),
              const BookDownloadSection(),
              const SizedBox(height: 34),
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

  Widget _buildBookCatalog(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final books = digitalProducts
        .where((product) => product.isPublished && product.type == DigitalProductType.ebook)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Published PDF Books',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Bengali learning guides written by Md Jahangir Alam.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final count = constraints.maxWidth >= 850
                ? 2
                : 1;
            const spacing = 18.0;
            final itemWidth =
                (constraints.maxWidth - spacing * (count - 1)) / count;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: books
                  .map(
                    (book) => SizedBox(
                      width: itemWidth,
                      child: _BookCard(
                        product: book,
                        onOrder: () => _showOrderDialog(context, book),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Future<void> _showOrderDialog(
    BuildContext context,
    DigitalProduct product,
  ) async {
    final orderId = await showDialog<String>(
      context: context,
      builder: (_) => BookOrderDialog(product: product),
    );

    // The order dialog itself displays the success state and Order ID.
    if (!context.mounted || orderId == null) return;

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
                  'More Learning Resources Coming Soon',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'New video courses and practical digital resources will be added here. '
                  'The two published Bengali PDF books are available to order above.',
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
          const SizedBox(height: 18),
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

class _BookCard extends StatelessWidget {
  final DigitalProduct product;
  final VoidCallback onOrder;

  const _BookCard({
    required this.product,
    required this.onOrder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final price = product.priceMinor ~/ 100;

    return Container(
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
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.menu_book_rounded, color: colors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'BENGALI PDF EBOOK',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'AVAILABLE',
                  style: TextStyle(
                    color: Color(0xFF166534),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            product.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final priceText = Text(
                '৳$price',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w800,
                ),
              );
              final orderButton = FilledButton.icon(
                onPressed: onOrder,
                icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                label: const Text('অর্ডার করুন'),
              );

              if (constraints.maxWidth < 300) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    priceText,
                    const SizedBox(height: 10),
                    orderButton,
                  ],
                );
              }

              return Row(
                children: [
                  priceText,
                  const Spacer(),
                  orderButton,
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            'অর্ডার ও পেমেন্টের বিস্তারিত জানতে যোগাযোগ করুন।',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
