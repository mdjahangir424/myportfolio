
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool centered;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.centered = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 55,
          height: 4,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: colors.onSurface.withOpacity(0.65),
            fontSize: 15,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}
