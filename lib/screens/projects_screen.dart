
import 'package:flutter/material.dart';

import '../data/projects_data.dart';
import '../widgets/section_title.dart';
import '../widgets/project_card.dart';
import '../widgets/footer.dart';

class ProjectsScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const ProjectsScreen({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 40,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SectionTitle(
                      title: 'My Projects',
                      subtitle:
                          'Explore my applications, AI solutions, and development work.',
                    ),

                    const SizedBox(height: 40),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 1;

                        if (constraints.maxWidth >= 900) {
                          crossAxisCount = 3;
                        } else if (constraints.maxWidth >= 600) {
                          crossAxisCount = 2;
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount: projectsData.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 22,
                            mainAxisSpacing: 22,
                            mainAxisExtent: 580,
                          ),
                          itemBuilder: (context, index) {
                            final project = projectsData[index];

                            return ProjectCard(
                              title: project.title,
                              description: project.description,
                              category: project.category,
                              status: project.status,
                              technologies: project.technologies,
                              image: project.image,
                              githubUrl: project.githubUrl,
                              liveUrl: project.liveUrl,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Shared Footer
          PortfolioFooter(
            onNavigate: onNavigate,
          ),
        ],
      ),
    );
  }
}
