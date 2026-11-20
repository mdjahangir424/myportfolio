import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/projects_data.dart';

class FeaturedProjectsCarousel extends StatefulWidget {
  final VoidCallback onViewProjects;

  const FeaturedProjectsCarousel({
    super.key,
    required this.onViewProjects,
  });

  @override
  State<FeaturedProjectsCarousel> createState() =>
      _FeaturedProjectsCarouselState();
}

class _FeaturedProjectsCarouselState extends State<FeaturedProjectsCarousel> {
  late final PageController _pageController;
  Timer? _autoPlayTimer;
  int _currentPage = 0;
  bool _isHovered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_controllerInitialized) {
      final width = MediaQuery.sizeOf(context).width;
      final fraction = width < 650 ? 0.84 : (width < 1000 ? 0.48 : 0.32);
      _pageController = PageController(viewportFraction: fraction);
      _controllerInitialized = true;
      _startAutoPlay();
    }
  }

  bool _controllerInitialized = false;

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || _isHovered || !_pageController.hasClients) return;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _moveTo(int page) {
    if (!_pageController.hasClients) return;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    if (_controllerInitialized) _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 42),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.primary.withValues(alpha: 0.94),
            Color.lerp(colors.primary, colors.tertiary, 0.48)!,
            colors.primary.withValues(alpha: 0.94),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Featured Projects',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            "A glimpse of what I've been building",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.82),
            ),
          ),
          const SizedBox(height: 28),
          MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: SizedBox(
              height: 248,
              child: PageView.builder(
                controller: _pageController,
                itemCount: null,
                padEnds: false,
                onPageChanged: (page) {
                  setState(() => _currentPage = page);
                },
                itemBuilder: (context, index) {
                  final project = projectsData[index % projectsData.length];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: _FeaturedProjectCard(
                      title: project.title,
                      category: project.category,
                      image: project.image,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                tooltip: 'Previous projects',
                onPressed: () => _moveTo(
                  _currentPage > 0 ? _currentPage - 1 : projectsData.length - 1,
                ),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              ...List.generate(5, (index) {
                final active = _currentPage % 5 == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: active ? 22 : 7,
                  height: 7,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: active
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.42),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
              const SizedBox(width: 8),
              IconButton(
                tooltip: 'Next projects',
                onPressed: () => _moveTo(_currentPage + 1),
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            onPressed: widget.onViewProjects,
            icon: const Icon(Icons.grid_view_rounded, size: 17),
            label: const Text('View All Projects'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.65)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedProjectCard extends StatelessWidget {
  final String title;
  final String category;
  final String image;

  const _FeaturedProjectCard({
    required this.title,
    required this.category,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isSvg = image.toLowerCase().endsWith('.svg');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: isSvg
                ? SvgPicture.asset(
                    image,
                    fit: BoxFit.cover,
                    placeholderBuilder: (_) => _imageFallback(colors),
                  )
                : Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _imageFallback(colors),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 11, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF172554),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageFallback(ColorScheme colors) {
    return Container(
      color: const Color(0xFFE8ECF5),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 38,
        color: colors.primary,
      ),
    );
  }
}
