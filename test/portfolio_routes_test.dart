import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/app/portfolio_routes.dart';
import 'package:portfolio/widgets/navbar.dart';

void main() {
  group('PortfolioRoutes', () {
    test('keeps Automation directly accessible without showing it in navigation', () {
      expect(PortfolioRoutes.paths, contains('/automation'));
      expect(PortfolioNavbar.navItems, isNot(contains('Automation')));
      expect(PortfolioNavbar.navItems, isNot(contains('Services')));
      expect(
        PortfolioRoutes.pathForNavigation(
          'Automation',
          PortfolioNavbar.navItems,
        ),
        isNull,
      );
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

    test('maps every navbar item to its explicitly defined route', () {
      const expectedRoutes = <String, String>{
        'Home': '/',
        'About': '/about',
        'Skills': '/skills',
        'Courses': '/courses',
        'Projects': '/projects',
        'Contact': '/contact',
      };

      expect(PortfolioNavbar.navItems, expectedRoutes.keys.toList());

      for (final entry in expectedRoutes.entries) {
        expect(
          PortfolioRoutes.pathForNavigation(
            entry.key,
            PortfolioNavbar.navItems,
          ),
          entry.value,
        );
      }
    });

    test('keeps Services available from the Skills preview and footer, not navbar', () {
      expect(PortfolioRoutes.paths, contains('/services'));
      expect(PortfolioNavbar.navItems, isNot(contains('Services')));
      expect(
        PortfolioRoutes.pathForNavigation(
          'Services',
          PortfolioNavbar.navItems,
        ),
        '/services',
      );
    });

    test('registers all legal pages as direct routes', () {
      expect(
        PortfolioRoutes.paths,
        containsAll([
          '/privacy-policy',
          '/terms-and-conditions',
          '/disclaimer',
        ]),
      );
    });

    test('maps legal footer labels to their routes', () {
      const expectedLegalRoutes = <String, String>{
        'Privacy Policy': '/privacy-policy',
        'Terms & Conditions': '/terms-and-conditions',
        'Disclaimer': '/disclaimer',
      };

      for (final entry in expectedLegalRoutes.entries) {
        expect(
          PortfolioRoutes.pathForNavigation(
            entry.key,
            PortfolioNavbar.navItems,
          ),
          entry.value,
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
