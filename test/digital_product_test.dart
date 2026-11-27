import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/data/digital_products_data.dart';
import 'package:portfolio/models/digital_product.dart';

void main() {
  group('Digital product catalog', () {
    test('supports all three product types', () {
      expect(DigitalProductType.values, contains(DigitalProductType.course));
      expect(DigitalProductType.values, contains(DigitalProductType.ebook));
      expect(
        DigitalProductType.values,
        contains(DigitalProductType.digitalProduct),
      );
    });

    test('does not advertise unconfigured products', () {
      expect(digitalProducts, isEmpty);
    });

    test('product model stores confirmed product details', () {
      const product = DigitalProduct(
        id: 'flutter-basics',
        title: 'Flutter Basics',
        description: 'A practical Flutter course.',
        type: DigitalProductType.course,
        priceMinor: 150000,
      );

      expect(product.id, 'flutter-basics');
      expect(product.type, DigitalProductType.course);
      expect(product.priceMinor, 150000);
      expect(product.currency, 'BDT');
      expect(product.isPublished, isFalse);
    });
  });
}
