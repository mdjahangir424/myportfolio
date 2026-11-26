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
    final categories = skillsData
        .map((skill) => skill.category)
        .toSet()
        .toList();
    final categoryKeys = categories
        .map((_) => GlobalKey<_SkillCategoryBlockState>())
        .toList();

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification ||
            notification is ScrollStartNotification ||
            notification is ScrollEndNotification) {
          for (final key in categoryKeys) {
            key.currentState?.startIfVisible();
          }
        }
        return false;
      },
      child: SharedScreenLayout(
        onNavigate: onNavigate,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 56,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionTitle(
                  title: 'My Skills',
                  subtitle:
                      'Technologies and tools I use to build '
                      'modern applications and intelligent solutions.',
                ),
                const SizedBox(height: 38),
                ...List.generate(categories.length, (index) {
                  final category = categories[index];
                  final categorySkills = skillsData
                      .where((skill) => skill.category == category)
                      .toList();

                  return _SkillCategoryBlock(
                    key: categoryKeys[index],
                    category: category,
                    skills: categorySkills,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillCategoryBlock extends StatefulWidget {
  final String category;
  final List<SkillData> skills;

  const _SkillCategoryBlock({
    super.key,
    required this.category,
    required this.skills,
  });

  @override
  State<_SkillCategoryBlock> createState() => _SkillCategoryBlockState();
}

class _SkillCategoryBlockState extends State<_SkillCategoryBlock>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();
    _controllers = widget.skills
        .map(
          (_) => AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1350),
          ),
        )
        .toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) startIfVisible();
    });
  }

  void startIfVisible() {
    if (_hasStarted || !mounted) return;

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final top = renderObject.localToGlobal(Offset.zero).dy;
    final bottom = top + renderObject.size.height;
    final viewportHeight = MediaQuery.sizeOf(context).height;

    if (bottom <= 0 || top >= viewportHeight) return;

    _hasStarted = true;
    for (var index = 0; index < _controllers.length; index++) {
      Future<void>.delayed(Duration(milliseconds: index * 130), () {
        if (mounted) _controllers[index].forward();
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.035),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
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
                  widget.category,
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
                  '${widget.skills.length} Skills',
                  style: TextStyle(
                    color: colors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...List.generate(widget.skills.length, (index) {
            return _SkillProgressRow(
              skill: widget.skills[index],
              progress: CurvedAnimation(
                parent: _controllers[index],
                curve: Curves.easeOutCubic,
              ),
              isLast: index == widget.skills.length - 1,
            );
          }),
        ],
      ),
    );
  }
}

class _SkillProgressRow extends StatelessWidget {
  final SkillData skill;
  final Animation<double> progress;
  final bool isLast;

  const _SkillProgressRow({
    required this.skill,
    required this.progress,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final animatedScore = skill.score == null
            ? null
            : (skill.score! * progress.value).round();

        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 12 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      skill.icon,
                      color: colors.primary,
                      size: 19,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          skill.name,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          skill.level,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    animatedScore == null ? 'Learning' : '$animatedScore%',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              if (skill.score != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 8,
                    width: double.infinity,
                    color: colors.surfaceContainerHighest,
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: (skill.score! / 100) * progress.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 7),
              ],
              Text(
                skill.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  height: 1.5,
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.75,
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
