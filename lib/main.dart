import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/portfolio_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(
    PortfolioApp(initialDarkMode: isDarkMode),
  );

  // Expose Flutter's semantics tree to assistive technologies on the web.
  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }
}
