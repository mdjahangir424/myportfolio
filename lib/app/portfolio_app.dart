
import 'package:flutter/material.dart';

import 'app_theme.dart';
import '../widgets/navbar.dart';
import '../screens/home_screen.dart';
import '../screens/about_screen.dart';
import '../screens/skills_screen.dart';
import '../screens/services_screen.dart';
import '../screens/projects_screen.dart';
import '../screens/automation_screen.dart';
import '../screens/contact_screen.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool _isDarkMode = false;
  int _selectedIndex = 0;

  final List<String> _navigationItems = [
    'Home',
    'About',
    'Skills',
    'Services',
    'Projects',
    'Automation',
    'Contact',
  ];

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(
          onViewProjects: () => _navigateTo(4),
          onContact: () => _navigateTo(6),
        );
      case 1:
        return const AboutScreen();
      case 2:
        return const SkillsScreen();
      case 3:
        return const ServicesScreen();
      case 4:
        return const ProjectsScreen();
      case 5:
        return const AutomationScreen();
      case 6:
        return const ContactScreen();
      default:
        return const HomeScreen(
          onViewProjects: null,
          onContact: null,
        );
    }
  }

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleNavigation(String item) {
    final index = _navigationItems.indexOf(item);

    if (index != -1) {
      _navigateTo(index);
    }
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
                onNavigate: _handleNavigation,
              ),
              Expanded(
                child: _getSelectedScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
