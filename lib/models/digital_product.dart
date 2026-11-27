enum DigitalProductType {
  course,
  ebook,
  digitalProduct,
}

class DigitalProduct {
  final String id;
  final String title;
  final String description;
  final DigitalProductType type;
  final int priceMinor;
  final String currency;
  final String? imageAsset;
  final bool isPublished;

  const DigitalProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.priceMinor,
    this.currency = 'BDT',
    this.imageAsset,
    this.isPublished = false,
  });
}
