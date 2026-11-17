
import 'package:flutter/material.dart';
import 'app_theme.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool _isDarkMode = false;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$message section will be available soon.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Md Jahangir Alam | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              PortfolioNavbar(
                isDarkMode: _isDarkMode,
                onThemeChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
                onNavigate: _showMessage,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: HeroSection(
                    onViewProjects: () => _showMessage('Projects'),
                    onContact: () => _showMessage('Contact'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
