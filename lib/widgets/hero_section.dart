
import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 750;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 70,
            vertical: isMobile ? 60 : 100,
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIntroduction(context),
                    const SizedBox(height: 50),
                    Center(child: _buildProfileVisual(context)),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildIntroduction(context),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: _buildProfileVisual(context),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildIntroduction(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: colors.primary.withOpacity(0.10),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'AVAILABLE FOR OPPORTUNITIES',
            style: TextStyle(
              color: colors.primary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Hello, I am',
          style: TextStyle(
            color: colors.onSurface.withOpacity(0.7),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Md Jahangir Alam',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 42,
            height: 1.15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Flutter Developer & AI Automation Specialist',
          style: TextStyle(
            color: colors.primary,
            fontSize: 22,
            height: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'I build modern cross-platform applications and intelligent automation solutions. I focus on creating reliable digital experiences that help businesses work smarter.',
          style: TextStyle(
            color: colors.onSurface.withOpacity(0.75),
            fontSize: 16,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            ElevatedButton.icon(
              onPressed: onViewProjects,
              icon: const Icon(Icons.work_outline),
              label: const Text('View Projects'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: onContact,
              icon: const Icon(Icons.mail_outline),
              label: const Text('Contact Me'),
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.primary,
                side: BorderSide(color: colors.primary),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileVisual(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 280,
      height: 320,
      decoration: BoxDecoration(
        color: colors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colors.primary.withOpacity(0.18),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withOpacity(0.20),
                  blurRadius: 30,
                  spreadRadius: 4,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'JA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Flutter Developer',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Building Digital Solutions',
            style: TextStyle(
              color: colors.onSurface.withOpacity(0.65),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
