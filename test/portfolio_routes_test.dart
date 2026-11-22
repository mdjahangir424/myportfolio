import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/app/portfolio_routes.dart';
import 'package:portfolio/widgets/navbar.dart';

void main() {
  group('PortfolioRoutes', () {
    test('defines the same number of routes as navigation items', () {
      expect(PortfolioRoutes.paths.length, PortfolioNavbar.navItems.length);
    });

    for (final path in PortfolioRoutes.paths) {
      test('accepts canonical route $path', () {
        expect(PortfolioRoutes.redirect(path), isNull);
      });
    }

    test('normalizes trailing slashes on known routes', () {
      for (final path in PortfolioRoutes.paths.where((p) => p != '/')) {
        expect(PortfolioRoutes.redirect('$path/'), path);
        expect(PortfolioRoutes.redirect('$path///'), path);
      }
    });

    test('redirects unknown paths to Home', () {
      expect(PortfolioRoutes.redirect('/not-a-real-page'), '/');
      expect(PortfolioRoutes.redirect('/projects/extra'), '/');
    });

    test('maps every navbar item to its matching route', () {
      for (var i = 0; i < PortfolioNavbar.navItems.length; i++) {
        expect(
          PortfolioRoutes.pathForNavigation(
            PortfolioNavbar.navItems[i],
            PortfolioNavbar.navItems,
          ),
          PortfolioRoutes.paths[i],
        );
      }
    });

    test('returns null for unknown navigation labels', () {
      expect(
        PortfolioRoutes.pathForNavigation('Unknown', PortfolioNavbar.navItems),
        isNull,
      );
    });
  });
}
