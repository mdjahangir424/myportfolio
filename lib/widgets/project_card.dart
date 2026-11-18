
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _openLink(String url) async {
    if (url.trim().isEmpty) return;

    final uri = Uri.tryParse(url.trim());

    if (uri == null ||
        (uri.scheme != 'https' && uri.scheme != 'http')) {
      return;
    }

    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Could not open link: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final techList = technologies
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .take(4)
        .toList();

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
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: techList.map((tech) {
                      return Chip(
                        label: Text(
                          tech,
                          style: const TextStyle(fontSize: 10),
                        ),
                        visualDensity: VisualDensity.compact,
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  Text(
                    'Status: $status',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      if (githubUrl.isNotEmpty)
                        OutlinedButton.icon(
                          onPressed: () => _openLink(githubUrl),
                          icon: const Icon(Icons.code),
                          label: const Text('GitHub'),
                        ),
                      if (liveUrl.isNotEmpty)
                        FilledButton.icon(
                          onPressed: () => _openLink(liveUrl),
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('Live Demo'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
