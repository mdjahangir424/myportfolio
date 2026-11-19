
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final bool initialDarkMode;

  const PortfolioApp({
    super.key,
    required this.initialDarkMode,
  });

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  late bool _isDarkMode;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.initialDarkMode;
  }

  Future<void> _saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  Future<void> _refreshPage() async {
    html.window.location.reload();
  }

  void _navigateTo(String item) {
    final index = PortfolioNavbar.navItems.indexOf(item);

    if (index >= 0) {
      _navigateToIndex(index);
    }
  }

  void _navigateToIndex(int index) {
    if (index < 0 || index > 6 || index == _selectedIndex) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(
          onViewProjects: () => _navigateToIndex(4),
          onContact: () => _navigateToIndex(6),
          onNavigate: _navigateTo,
        );

      case 1:
        return AboutScreen(
          onNavigate: _navigateTo,
        );

      case 2:
        return SkillsScreen(
          onNavigate: _navigateTo,
        );

      case 3:
        return ServicesScreen(
          onNavigate: _navigateTo,
        );

      case 4:
        return ProjectsScreen(
          onNavigate: _navigateTo,
        );

      case 5:
        return AutomationScreen(
          onNavigate: _navigateTo,
        );

      case 6:
        return ContactScreen(
          onNavigate: _navigateTo,
        );

      default:
        return HomeScreen(
          onViewProjects: () => _navigateToIndex(4),
          onContact: () => _navigateToIndex(6),
          onNavigate: _navigateTo,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Md Jahangir Alam | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      home: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  PortfolioNavbar(
                    isDarkMode: _isDarkMode,
                    onThemeChanged: (value) {
                      if (_isDarkMode == value) return;

                      setState(() {
                        _isDarkMode = value;
                      });

                      _saveThemePreference(value);
                    },
                    onNavigate: _navigateTo,
                  ),

                  Expanded(
                    child: ScrollConfiguration(
                      behavior: const _RefreshScrollBehavior(),
                      child: RefreshIndicator(
                        onRefresh: _refreshPage,
                        color: Theme.of(context)
                            .colorScheme.primary,
                        backgroundColor: Theme.of(context)
                            .cardColor,
                        strokeWidth: 3,
                        displacement: 55,
                        child: _getSelectedScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RefreshScrollBehavior extends MaterialScrollBehavior {
  const _RefreshScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const AlwaysScrollableScrollPhysics(
      parent: BouncingScrollPhysics(),
    );
  }
}
