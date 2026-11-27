/// Shared route definitions and normalization for the portfolio app.
class PortfolioRoutes {
  PortfolioRoutes._();

  static const List<String> paths = [
    '/',
    '/about',
    '/skills',
    '/services',
    '/courses',
    '/projects',
    '/automation',
    '/contact',
    '/privacy-policy',
    '/terms-and-conditions',
    '/disclaimer',
  ];

  /// Returns a canonical route for a known path, or Home for an unknown path.
  static String? redirect(String path) {
    final normalized = path.length > 1
        ? path.replaceFirst(RegExp(r'/+$'), '')
        : path;
    if (!paths.contains(normalized)) return '/';
    return normalized == path ? null : normalized;
  }

  /// Maps navigation labels explicitly so hidden routes do not shift menu links.
  static String? pathForNavigation(String item, List<String> navigationItems) {
    if (!navigationItems.contains(item)) {
      return switch (item) {
        'Services' => '/services',
        'Privacy Policy' => '/privacy-policy',
        'Terms & Conditions' => '/terms-and-conditions',
        'Disclaimer' => '/disclaimer',
        _ => null,
      };
    }

    return switch (item) {
      'Home' => '/',
      'About' => '/about',
      'Skills' => '/skills',
      'Courses' => '/courses',
      'Projects' => '/projects',
      'Automation' => '/automation',
      'Contact' => '/contact',
      _ => null,
    };
  }
}
