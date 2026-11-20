
import 'package:flutter/material.dart';

import '../widgets/hero_section.dart';
import '../widgets/featured_projects_carousel.dart';
import '../widgets/shared_screen_layout.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContact;
  final ValueChanged<String> onNavigate;

  const HomeScreen({
    super.key,
    required this.onViewProjects,
    required this.onContact,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SharedScreenLayout(
      onNavigate: onNavigate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HeroSection(
            onViewProjects: onViewProjects,
            onContact: onContact,
          ),

          const SizedBox(height: 48),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              children: [
                Text(
                  'Building Digital Experiences',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 16),

                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 700,
                  ),
                  child: Text(
                    'I focus on Flutter application development, '
                    'AI agent development and workflow automation '
                    'to create practical digital solutions.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                          height: 1.8,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.75),
                        ),
                  ),
                ),

                const SizedBox(height: 36),

                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _HomeFeature(
                      icon: Icons.phone_android,
                      title: 'Flutter Development',
                    ),
                    _HomeFeature(
                      icon: Icons.smart_toy,
                      title: 'AI Agent Development',
                    ),
                    _HomeFeature(
                      icon: Icons.account_tree,
                      title: 'Workflow Automation',
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          FeaturedProjectsCarousel(
            onViewProjects: onViewProjects,
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

class _HomeFeature extends StatelessWidget {
  final IconData icon;
  final String title;

  const _HomeFeature({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 34,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
