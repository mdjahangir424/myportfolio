import 'package:flutter/material.dart';
import 'footer.dart';

class SharedScreenLayout extends StatelessWidget {
  final Widget child;
  final ValueChanged<String> onNavigate;
  final EdgeInsetsGeometry padding;

  const SharedScreenLayout({
    super.key,
    required this.child,
    required this.onNavigate,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 24,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: padding,
            child: child,
          ),
          PortfolioFooter(
            onNavigate: onNavigate,
          ),
        ],
      ),
    );
  }
}