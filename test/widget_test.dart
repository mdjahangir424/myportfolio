import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/data/projects_data.dart';
import 'package:portfolio/data/social_data.dart';
import 'package:portfolio/widgets/navbar.dart';

void main() {
  group('projectsData', () {
    test('is not empty', () {
      expect(projectsData, isNotEmpty);
    });

    test('every project has a title and an existing image file', () {
      for (final project in projectsData) {
        expect(project.title.trim(), isNotEmpty);
        expect(
          File(project.image).existsSync(),
          isTrue,
          reason: 'Missing image for ${project.title}: ${project.image}',
        );
      }
    });

    test('links are empty or https', () {
      for (final project in projectsData) {
        for (final url in [project.githubUrl, project.liveUrl]) {
          if (url.isEmpty) continue;
          expect(
            Uri.parse(url).scheme,
            'https',
            reason: '${project.title} has a non-https link: $url',
          );
        }
      }
    });
  });

  group('socialData', () {
    test('names are unique', () {
      final names = socialData.map((s) => s.name).toList();
      expect(names.toSet().length, names.length);
    });

    test('urls use https or mailto', () {
      for (final social in socialData) {
        expect(
          ['https', 'mailto'],
          contains(Uri.parse(social.url).scheme),
          reason: '${social.name}: ${social.url}',
        );
      }
    });
  });
}


  group('Mobile navigation', () {
    testWidgets('opens the end drawer and navigates after selection',
        (tester) async {
      final scaffoldKey = GlobalKey<ScaffoldState>();
      String? selectedItem;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            endDrawer: PortfolioNavigationDrawer(
              onNavigate: (item) => selectedItem = item,
            ),
            body: Align(
              alignment: Alignment.topRight,
              child: PortfolioNavbar(
                isDarkMode: false,
                onThemeChanged: (_) {},
                onNavigate: (_) {},
                onMenuPressed: () =>
                    scaffoldKey.currentState?.openEndDrawer(),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      expect(find.text('Portfolio Navigation'), findsOneWidget);

      await tester.tap(find.widgetWithText(ListTile, 'Projects'));
      await tester.pumpAndSettle();

      expect(selectedItem, 'Projects');
      expect(find.text('Portfolio Navigation'), findsNothing);
    });
  });
