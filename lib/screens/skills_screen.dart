import 'dart:ui' show FontFeature;

import 'package:flutter/material.dart';

import '../data/skills_data.dart';
import '../widgets/section_title.dart';
import '../widgets/shared_screen_layout.dart';

class SkillsScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const SkillsScreen({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final categories = skillsData
        .map((skill) => skill.category)
        .toSet()
        .toList();

    return SharedScreenLayout(
      onNavigate: onNavigate,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 56,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1150,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionTitle(
                title: 'My Skills',
                subtitle:
                    'Technologies and tools I use to build '
                    'modern applications and intelligent solutions.',
              ),
              const SizedBox(height: 42),
              ...categories.map((category) {
                final categorySkills = skillsData
                    .where((skill) => skill.category == category)
                    .toList();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 42),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 5,
                            height: 28,
                            decoration: BoxDecoration(
                              color: colors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              category,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              '${categorySkills.length} Skills',
                              style: TextStyle(
                                color: colors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final columns = constraints.maxWidth >= 900
                              ? 3
                              : constraints.maxWidth >= 560
                                  ? 2
                                  : 1;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categorySkills.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18,
                              mainAxisExtent: 258,
                            ),
                            itemBuilder: (context, index) {
                              final skill = categorySkills[index];

                              return _AnimatedSkillCard(
                                key: ValueKey(skill.name),
                                skill: skill,
                                animationDelay: Duration(
                                  milliseconds:
                                      skillsData.indexOf(skill) * 110,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedSkillCard extends StatefulWidget {
  final SkillData skill;
  final Duration animationDelay;

  const _AnimatedSkillCard({
    super.key,
    required this.skill,
    required this.animationDelay,
  });

  @override
  State<_AnimatedSkillCard> createState() => _AnimatedSkillCardState();
}

class _AnimatedSkillCardState extends State<_AnimatedSkillCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _progress = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    Future<void>.delayed(widget.animationDelay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final skill = widget.skill;

    return AnimatedBuilder(
      animation: _progress,
      builder: (context, child) {
        final animatedScore = (skill.score * _progress.value).round();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: colors.outlineVariant,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.shadow.withValues(alpha: 0.035),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      skill.icon,
                      color: colors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      skill.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                skill.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.42,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      skill.level,
                      style: TextStyle(
                        color: colors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Proficiency',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$animatedScore%',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 7,
                  color: colors.surfaceContainerHighest,
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: (skill.score / 100) * _progress.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
