
import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onContact,
  });

  static const String profileImage =
      'assets/images/jahangir_profile.png';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 750;

        final introduction = _buildIntroduction(
          context,
          isMobile,
        );

        final profile = _buildProfileVisual(context);

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 70,
            vertical: isMobile ? 55 : 90,
          ),
          decoration: BoxDecoration(
            color: colors.surface,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1150,
              ),
              child: isMobile
                  ? Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        introduction,
                        const SizedBox(height: 45),
                        Center(child: profile),
                      ],
                    )
                  : Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: introduction,
                        ),
                        const SizedBox(width: 55),
                        Expanded(
                          flex: 4,
                          child: Center(child: profile),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIntroduction(
    BuildContext context,
    bool isMobile,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'AVAILABLE FOR OPPORTUNITIES',
            style: TextStyle(
              color: colors.primary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),

        const SizedBox(height: 26),

        Text(
          'Hello, I am',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colors.onSurface.withValues(alpha: 0.70),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Md Jahangir Alam',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: isMobile ? 34 : 46,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Flutter Developer &\nAI Automation Specialist',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colors.primary,
            fontSize: isMobile ? 20 : 25,
            fontWeight: FontWeight.w700,
            height: 1.45,
          ),
        ),

        const SizedBox(height: 22),

        Text(
          'I build modern cross-platform applications and '
          'intelligent automation solutions. I focus on '
          'creating reliable digital experiences that help '
          'businesses and individuals work smarter.',
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.85,
            color: colors.onSurface.withValues(alpha: 0.78),
          ),
        ),

        const SizedBox(height: 30),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: onViewProjects,
              icon: const Icon(Icons.work_outline),
              label: const Text('View Projects'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 17,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),

            OutlinedButton.icon(
              onPressed: onContact,
              icon: const Icon(Icons.mail_outline),
              label: const Text('Contact Me'),
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.primary,
                side: BorderSide(
                  color: colors.primary,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 17,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _HeroSkillChip(
              icon: Icons.phone_android,
              label: 'Flutter',
            ),
            _HeroSkillChip(
              icon: Icons.smart_toy_outlined,
              label: 'AI Agents',
            ),
            _HeroSkillChip(
              icon: Icons.account_tree_outlined,
              label: 'Automation',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileVisual(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      constraints: const BoxConstraints(
        maxWidth: 360,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.primary,
            colors.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.17),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: AspectRatio(
          aspectRatio: 0.82,
          child: Image.asset(
            profileImage,
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
    );
  }
}

class _HeroSkillChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroSkillChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
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
            size: 16,
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
