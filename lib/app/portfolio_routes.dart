/// Shared route definitions and normalization for the portfolio app.
class PortfolioRoutes {
  PortfolioRoutes._();

  static const List<String> paths = [
    '/',
    '/about',
    '/skills',
    '/services',
    '/projects',
    '/automation',
    '/contact',
  ];

  /// Returns a canonical route for a known path, or Home for an unknown path.
  static String? redirect(String path) {
    final normalized = path.length > 1
        ? path.replaceFirst(RegExp(r'/+$'), '')
        : path;
    return paths.contains(normalized) ? null : '/';
  }

  /// Maps a navigation label to its route without relying on duplicated indexes.
  static String? pathForNavigation(String item, List<String> navigationItems) {
    final index = navigationItems.indexOf(item);
    if (index < 0 || index >= paths.length) return null;
    return paths[index];
  }
}
