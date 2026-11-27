import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/screens/courses_screen.dart';

void main() {
  group('CoursesScreen', () {
    testWidgets('shows the three learning store categories', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CoursesScreen(onNavigate: (_) {}),
          ),
        ),
      );

      expect(find.text('Courses & Digital Products'), findsOneWidget);
      expect(find.text('Online Courses'), findsOneWidget);
      expect(find.text('PDF Books & eBooks'), findsOneWidget);
      expect(find.text('Digital Products'), findsOneWidget);
      expect(find.text('Published PDF Books'), findsOneWidget);
      expect(find.text('Flutter Basic to Advanced'), findsOneWidget);
      expect(find.text('AI Automation: শূন্য থেকে অ্যাডভান্সড'), findsOneWidget);
      expect(find.text('৳299'), findsOneWidget);
      expect(find.text('৳199'), findsOneWidget);
      expect(find.text('More Learning Resources Coming Soon'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    for (final width in [320.0, 375.0, 600.0, 850.0, 1024.0, 1440.0]) {
      testWidgets('renders responsively at ${width.toInt()}px', (tester) async {
        tester.view.physicalSize = Size(width, 1100);
        tester.view.devicePixelRatio = 1;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CoursesScreen(onNavigate: (_) {}),
            ),
          ),
        );

        expect(tester.takeException(), isNull);

        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });
      });
    }

    testWidgets('contact button navigates to Contact', (tester) async {
      String? destination;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CoursesScreen(onNavigate: (value) => destination = value),
          ),
        ),
      );

      await tester.ensureVisible(find.text('Contact Me'));
      await tester.tap(find.text('Contact Me'));
      expect(destination, 'Contact');
    });
  });
}
