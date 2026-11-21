import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/data/projects_data.dart';
import 'package:portfolio/data/social_data.dart';

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
