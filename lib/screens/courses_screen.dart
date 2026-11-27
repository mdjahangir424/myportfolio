import 'package:flutter/material.dart';

import '../widgets/section_title.dart';
import '../widgets/shared_screen_layout.dart';

class CoursesScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const CoursesScreen({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SharedScreenLayout(
      onNavigate: onNavigate,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 56),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const SectionTitle(
                title: 'Courses & Digital Books',
                subtitle:
                    'Practical learning resources to help you build skills '
                    'in app development, software, and AI automation.',
              ),
              const SizedBox(height: 42),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 52,
                ),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: colors.outlineVariant),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Icon(
                        Icons.menu_book_rounded,
                        size: 38,
                        color: colors.primary,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Learning Store Coming Soon',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Courses, eBooks, and other digital learning products '
                      'will be available here. All learning resources will '
                      'be organized in one place.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.65,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 26),
                    OutlinedButton.icon(
                      onPressed: () => onNavigate('Contact'),
                      icon: const Icon(Icons.mail_outline_rounded),
                      label: const Text('Contact Me'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
