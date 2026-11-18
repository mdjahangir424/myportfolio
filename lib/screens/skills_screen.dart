

import 'package:flutter/material.dart';

import '../data/skills_data.dart';
import '../widgets/section_title.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final categories = skillsData
        .map((skill) => skill.category)
        .toSet()
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 70,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const SectionTitle(
                title: 'My Skills',
                subtitle:
                    'Technologies and tools I work with.',
              ),
              const SizedBox(height: 50),

              ...categories.map((category) {
                final categorySkills = skillsData
                    .where((skill) => skill.category == category)
                    .toList();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                            ),
                      ),
                      const SizedBox(height: 18),

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
                              mainAxisExtent: 125,
                            ),
                            itemBuilder: (context, index) {
                              final skill = categorySkills[index];

                              return Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: colors.surface,
                                  borderRadius:
                                      BorderRadius.circular(14),
                                  border: Border.all(
                                    color: colors.outlineVariant,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: colors.primary
                                            .withValues(alpha: 0.10),
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        skill.icon,
                                        color: colors.primary,
                                        size: 25,
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
                                            style: const TextStyle(
                                              fontWeight:
                                                  FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          Text(
                                            skill.level,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: colors.onSurface
                                                  .withValues(
                                                alpha: 0.65,
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
