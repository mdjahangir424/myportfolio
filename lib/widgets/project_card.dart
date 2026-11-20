import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    if (uri == null || (uri.scheme != 'https' && uri.scheme != 'http')) return;
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened) debugPrint('Could not open URL: $url');
    } catch (e) {
      debugPrint('Could not open link: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final techList = technologies.split(',').map((item) => item.trim()).where((item) => item.isNotEmpty).take(5).toList();

    Widget imageFallback() => Container(
      color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
      child: Icon(Icons.image_not_supported_outlined, size: 46, color: colors.onSurface.withValues(alpha: 0.45)),
    );

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colors.primary.withValues(alpha: isDark ? 0.22 : 0.10)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: isDark ? 0.16 : 0.055), blurRadius: 22, offset: const Offset(0, 8))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 185,
            width: double.infinity,
            child: _HoverZoomImage(
              child: image.toLowerCase().endsWith('.svg')
                  ? SvgPicture.asset(image, fit: BoxFit.cover, placeholderBuilder: (_) => imageFallback())
                  : Image.asset(image, fit: BoxFit.cover, errorBuilder: (_, __, ___) => imageFallback()),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(color: colors.primary.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(30)),
                    child: Text(category.toUpperCase(), style: TextStyle(color: colors.primary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
                  ),
                  const SizedBox(height: 12),
                  Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, height: 1.25)),
                  const SizedBox(height: 10),
                  Text(description, maxLines: 3, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodySmall?.copyWith(height: 1.6, color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.78))),
                  const SizedBox(height: 16),
                  Text('TECHNOLOGIES', style: theme.textTheme.labelSmall?.copyWith(color: colors.primary, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: techList.map((tech) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(color: colors.primary.withValues(alpha: 0.09), borderRadius: BorderRadius.circular(8)),
                      child: Text(tech, style: theme.textTheme.labelSmall?.copyWith(color: colors.primary, fontWeight: FontWeight.w600)),
                    )).toList(),
                  ),
                  const Spacer(),
                  Divider(color: theme.dividerColor.withValues(alpha: 0.35)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 9, color: status.toLowerCase().contains('complete') ? Colors.green : Colors.orange),
                      const SizedBox(width: 7),
                      Expanded(child: Text(status, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600))),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      if (githubUrl.trim().isNotEmpty)
                        Expanded(child: OutlinedButton.icon(
                          onPressed: () => _openLink(githubUrl),
                          icon: const Icon(Icons.code_rounded, size: 17),
                          label: const Text('GitHub'),
                          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))),
                        )),
                      if (githubUrl.trim().isNotEmpty && liveUrl.trim().isNotEmpty) const SizedBox(width: 10),
                      if (liveUrl.trim().isNotEmpty)
                        Expanded(child: FilledButton.icon(
                          onPressed: () => _openLink(liveUrl),
                          icon: const Icon(Icons.open_in_new_rounded, size: 16),
                          label: const Text('Live Demo'),
                          style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))),
                        )),
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

class _HoverZoomImage extends StatefulWidget {
  final Widget child;

  const _HoverZoomImage({required this.child});

  @override
  State<_HoverZoomImage> createState() => _HoverZoomImageState();
}

class _HoverZoomImageState extends State<_HoverZoomImage> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ClipRect(
        child: AnimatedScale(
          scale: _isHovered ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: widget.child,
        ),
      ),
    );
  }
}
