import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/utils/external_link.dart';

void main() {
  group('launchExternalUrl', () {
    test('rejects malformed and relative URLs safely', () async {
      expect(await launchExternalUrl('not a URL'), isFalse);
      expect(await launchExternalUrl('/projects'), isFalse);
      expect(await launchExternalUrl(''), isFalse);
    });

    test('rejects unsupported schemes', () async {
      expect(await launchExternalUrl('javascript:alert(1)'), isFalse);
      expect(await launchExternalUrl('file:///etc/passwd'), isFalse);
    });
  });
}
