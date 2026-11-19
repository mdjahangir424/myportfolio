
import 'package:flutter/material.dart';

import '../widgets/section_title.dart';
import '../widgets/shared_screen_layout.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({
    super.key,
    required this.onNavigate,
  });

  final ValueChanged<String> onNavigate;

  static const String profileImage =
      'assets/images/jahangir_profile.png';

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return SharedScreenLayout(
      onNavigate: onNavigate,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 70,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1150),
          child: Column(
            children: [
              const SectionTitle(
                title: 'About Me',
                subtitle:
                    'Discover my journey, expertise and passion '
                    'for building digital experiences.',
              ),

              const SizedBox(height: 55),

              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 750;

                  final profile =
                      _buildProfileImage(context, isDark);

                  final introduction =
                      _buildIntroduction(context);

                  if (isMobile) {
                    return Column(
                      children: [
                        profile,
                        const SizedBox(height: 42),
                        introduction,
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: profile,
                      ),
                      const SizedBox(width: 55),
                      Expanded(
                        flex: 6,
                        child: introduction,
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 65),

              _buildExpertise(context),

              const SizedBox(height: 55),

              _buildGoalSection(context),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(
    BuildContext context,
    bool isDark,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 390),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primary, colors.tertiary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withValues(
                alpha: isDark ? 0.20 : 0.16,
              ),
              blurRadius: 30,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: AspectRatio(
            aspectRatio: 0.78,
            child: Image.asset(
              profileImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              filterQuality: FilterQuality.high,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: colors.surfaceContainerHighest,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.person_outline,
                    size: 100,
                    color: colors.primary,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroduction(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'GET TO KNOW ME',
            style: TextStyle(
              color: colors.primary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),

        const SizedBox(height: 22),

        Text('Hello, I am', style: theme.textTheme.titleLarge),

        const SizedBox(height: 5),

        Text(
          'Md Jahangir Alam',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Flutter Developer &\nAI Automation Specialist',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          'I am focused on Flutter application development, '
          'AI agent development and workflow automation. '
          'I enjoy exploring modern technologies and '
          'building practical digital solutions.',
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.9,
            color: colors.onSurface.withValues(alpha: 0.78),
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'My goal is to develop reliable, user-friendly '
          'applications and intelligent automation solutions '
          'that help businesses and individuals improve '
          'their digital experiences.',
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.9,
            color: colors.onSurface.withValues(alpha: 0.78),
          ),
        ),

        const SizedBox(height: 28),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _ExpertiseChip(
              icon: Icons.phone_android,
              label: 'Flutter',
            ),
            _ExpertiseChip(
              icon: Icons.smart_toy,
              label: 'AI Agents',
            ),
            _ExpertiseChip(
              icon: Icons.account_tree,
              label: 'Automation',
            ),
            _ExpertiseChip(
              icon: Icons.cloud_outlined,
              label: 'Firebase',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpertise(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final items = [
      (
        icon: Icons.phone_android,
        title: 'Mobile Development',
        description: 'Flutter and Dart application development.',
      ),
      (
        icon: Icons.psychology_outlined,
        title: 'AI Agent Development',
        description: 'Intelligent AI-powered digital solutions.',
      ),
      (
        icon: Icons.account_tree_outlined,
        title: 'Workflow Automation',
        description: 'Automating business processes with n8n.',
      ),
      (
        icon: Icons.cloud_outlined,
        title: 'Backend Integration',
        description: 'Firebase, REST APIs and webhooks.',
      ),
    ];

    return Column(
      children: [
        Text(
          'My Core Expertise',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Technologies and areas I focus on.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurface.withValues(alpha: 0.65),
          ),
        ),

        const SizedBox(height: 30),

        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 850
                ? 4
                : constraints.maxWidth >= 520
                    ? 2
                    : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                mainAxisExtent: 175,
              ),
              itemBuilder: (context, index) {
                final item = items[index];

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: colors.outlineVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        item.icon,
                        size: 30,
                        color: colors.primary,
                      ),

                      const SizedBox(height: 15),

                      Text(
                        item.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        item.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildGoalSection(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: colors.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.rocket_launch_outlined,
            size: 38,
            color: colors.primary,
          ),

          const SizedBox(height: 16),

          Text(
            'My Professional Goal',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 750),
            child: Text(
              'I aim to continuously improve my development '
              'skills, explore emerging AI technologies and '
              'create meaningful digital solutions through '
              'innovation, creativity and automation.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.8,
                color: colors.onSurface.withValues(alpha: 0.78),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpertiseChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ExpertiseChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: colors.outlineVariant,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 17,
            color: colors.primary,
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
