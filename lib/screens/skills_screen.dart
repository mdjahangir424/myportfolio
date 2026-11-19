
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
        horizontal: 24,
        vertical: 70,
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

              const SizedBox(height: 55),

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
                              color: colors.primary.withValues(
                                alpha: 0.10,
                              ),
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
                          final columns =
                              constraints.maxWidth >= 850
                                  ? 3
                                  : constraints.maxWidth >= 550
                                      ? 2
                                      : 1;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(),
                            itemCount: categorySkills.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18,
                              mainAxisExtent: 135,
                            ),
                            itemBuilder: (context, index) {
                              final skill = categorySkills[index];

                              return Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: theme.cardColor,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: colors.outlineVariant,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colors.shadow.withValues(
                                        alpha: 0.035,
                                      ),
                                      blurRadius: 14,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: colors.primary.withValues(
                                          alpha: 0.10,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                      child: Icon(
                                        skill.icon,
                                        color: colors.primary,
                                        size: 26,
                                      ),
                                    ),

                                    const SizedBox(width: 14),

                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            skill.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme
                                                .textTheme.titleSmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              height: 1.3,
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 9,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: colors.primary
                                                  .withValues(alpha: 0.08),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              skill.level,
                                              maxLines: 1,
                                              overflow:
                                                  TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: colors.primary,
                                              ),
                                            ),
                                          ),
                                        ],
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
