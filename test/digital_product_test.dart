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

    test('contains the two confirmed paid Bengali PDF books', () {
      expect(digitalProducts, hasLength(2));
      expect(
        digitalProducts.map((product) => product.title),
        containsAll([
          'Flutter Basic to Advanced',
          'AI Automation: শূন্য থেকে অ্যাডভান্সড',
        ]),
      );
      expect(digitalProducts.every((product) => product.isPublished), isTrue);
      expect(
        digitalProducts.every((product) => product.type == DigitalProductType.ebook),
        isTrue,
      );
    });

    test('stores the confirmed prices in BDT poisha', () {
      final flutterBook = digitalProducts.singleWhere(
        (product) => product.id == 'flutter-basic-to-advanced',
      );
      final aiBook = digitalProducts.singleWhere(
        (product) => product.id == 'ai-automation-zero-to-advanced',
      );

      expect(flutterBook.priceMinor, 29900);
      expect(aiBook.priceMinor, 19900);
      expect(flutterBook.currency, 'BDT');
      expect(aiBook.currency, 'BDT');
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
