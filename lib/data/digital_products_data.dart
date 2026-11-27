import '../models/digital_product.dart';

/// Confirmed paid PDF books for the Learning Store.
/// Prices are stored in poisha (৳299 = 29900).
const List<DigitalProduct> digitalProducts = [
  DigitalProduct(
    id: 'flutter-basic-to-advanced',
    title: 'Flutter Basic to Advanced',
    description:
        'A Bengali, 360-page guide with 62 chapters covering Dart, Flutter UI, '
        'state management, Firebase, REST APIs, clean architecture, practical '
        'projects, Git, GitHub, and professional Flutter development.',
    type: DigitalProductType.ebook,
    priceMinor: 29900,
    isPublished: true,
  ),
  DigitalProduct(
    id: 'ai-automation-zero-to-advanced',
    title: 'AI Automation: শূন্য থেকে অ্যাডভান্সড',
    description:
        'A Bengali, 21-chapter guide to AI fundamentals, prompt engineering, '
        'Make.com, n8n, Zapier, APIs, webhooks, AI agents, coding automation, '
        'deployment, security, and freelancing.',
    type: DigitalProductType.ebook,
    priceMinor: 19900,
    isPublished: true,
  ),
];
