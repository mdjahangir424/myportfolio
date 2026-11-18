
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String status;
  final String technologies;
  final String image;
  final String githubUrl;
  final String liveUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.technologies,
    required this.image,
    required this.githubUrl,
    required this.liveUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              image,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: isDark
                      ? Colors.grey.shade800
                      : Colors.grey.shade200,
                  child: const Center(
                    child: Icon(Icons.image_not_supported_outlined, size: 40),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.toUpperCase(),
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(description),
                const SizedBox(height: 12),
                Text(
                  'Technologies: $technologies',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                Text(
                  'Status: $status',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    if (githubUrl.isNotEmpty)
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.code),
                        label: const Text('GitHub'),
                      ),
                    if (liveUrl.isNotEmpty)
                      FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Live Demo'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
