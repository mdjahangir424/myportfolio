import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/web.dart' as web;

import 'app_theme.dart';
import '../widgets/navbar.dart';

import '../screens/home_screen.dart';
import '../screens/about_screen.dart' deferred as about;
import '../screens/skills_screen.dart' deferred as skills;
import '../screens/services_screen.dart' deferred as services;
import '../screens/projects_screen.dart' deferred as projects;
import '../screens/automation_screen.dart' deferred as automation;
import '../screens/contact_screen.dart' deferred as contact;

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
  /// Same order as [PortfolioNavbar.navItems].
  static const List<String> _paths = [
    '/',
    '/about',
    '/skills',
    '/services',
    '/projects',
    '/automation',
    '/contact',
  ];

  static const String _homeTitle =
      'Md Jahangir Alam | Flutter Developer & AI Automation Specialist';

  late bool _isDarkMode;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.initialDarkMode;
    _router = _createRouter();
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  GoRouter _createRouter() {
    return GoRouter(
      initialLocation: '/',
      // Unknown links go to Home instead of showing an error page.
      redirect: (context, state) {
        return _paths.contains(state.uri.path) ? null : '/';
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return _PortfolioShell(
              onThemeChanged: _setDarkMode,
              onNavigate: _navigateTo,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => _page(
                state,
                _homeTitle,
                HomeScreen(
                  onViewProjects: () => _navigateTo('Projects'),
                  onContact: () => _navigateTo('Contact'),
                  onNavigate: _navigateTo,
                ),
              ),
            ),
            GoRoute(
              path: '/about',
              pageBuilder: (context, state) => _page(
                state,
                'About | Md Jahangir Alam',
                _DeferredScreen(
                  loadLibrary: about.loadLibrary,
                  builder: (_) => about.AboutScreen(
                    onNavigate: _navigateTo,
                  ),
                ),
              ),
            ),
            GoRoute(
              path: '/skills',
              pageBuilder: (context, state) => _page(
                state,
                'Skills | Md Jahangir Alam',
                _DeferredScreen(
                  loadLibrary: skills.loadLibrary,
                  builder: (_) => skills.SkillsScreen(
                    onNavigate: _navigateTo,
                  ),
                ),
              ),
            ),
            GoRoute(
              path: '/services',
              pageBuilder: (context, state) => _page(
                state,
                'Services | Md Jahangir Alam',
                _DeferredScreen(
                  loadLibrary: services.loadLibrary,
                  builder: (_) => services.ServicesScreen(
                    onNavigate: _navigateTo,
                  ),
                ),
              ),
            ),
            GoRoute(
              path: '/projects',
              pageBuilder: (context, state) => _page(
                state,
                'Projects | Md Jahangir Alam',
                _DeferredScreen(
                  loadLibrary: projects.loadLibrary,
                  builder: (_) => projects.ProjectsScreen(
                    onNavigate: _navigateTo,
                  ),
                ),
              ),
            ),
            GoRoute(
              path: '/automation',
              pageBuilder: (context, state) => _page(
                state,
                'Automation | Md Jahangir Alam',
                _DeferredScreen(
                  loadLibrary: automation.loadLibrary,
                  builder: (_) => automation.AutomationScreen(
                    onNavigate: _navigateTo,
                  ),
                ),
              ),
            ),
            GoRoute(
              path: '/contact',
              pageBuilder: (context, state) => _page(
                state,
                'Contact | Md Jahangir Alam',
                _DeferredScreen(
                  loadLibrary: contact.loadLibrary,
                  builder: (_) => contact.ContactScreen(
                    onNavigate: _navigateTo,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// A page without a transition, with the browser tab title set.
  Page<void> _page(GoRouterState state, String title, Widget child) {
    return NoTransitionPage<void>(
      key: state.pageKey,
      child: Title(
        title: title,
        color: const Color(0xFF2563EB),
        child: child,
      ),
    );
  }

  void _reloadToHome() {
    // document.baseURI respects Firebase '/' and GitHub Pages '/myportfolio/'.
    web.window.location.assign(web.document.baseURI);
  }

  void _navigateTo(String item) {
    final index = PortfolioNavbar.navItems.indexOf(item);

    if (index >= 0 && index < _paths.length) {
      _router.go(_paths[index]);
    }
  }

  Future<void> _saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  void _setDarkMode(bool value) {
    if (_isDarkMode == value) return;

    setState(() {
      _isDarkMode = value;
    });

    _saveThemePreference(value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Md Jahangir Alam | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: _router,
    );
  }
}

/// Navbar + pull-to-refresh around the current page.
class _PortfolioShell extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onNavigate;
  final Widget child;

  const _PortfolioShell({
    required this.onThemeChanged,
    required this.onNavigate,
    required this.child,
  });

  @override
  State<_PortfolioShell> createState() => _PortfolioShellState();
}

class _PortfolioShellState extends State<_PortfolioShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _refreshPage() async {
    web.window.location.reload();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: PortfolioNavigationDrawer(
        onNavigate: widget.onNavigate,
      ),
      drawerEnableOpenDragGesture: false,
      body: SafeArea(
        child: Column(
          children: [
            PortfolioNavbar(
              isDarkMode: theme.brightness == Brightness.dark,
              onThemeChanged: widget.onThemeChanged,
              onNavigate: widget.onNavigate,
              onMenuPressed: () =>
                  _scaffoldKey.currentState?.openEndDrawer(),
              onLogoPressed: _reloadToHome,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: const _RefreshScrollBehavior(),
                child: RefreshIndicator(
                  onRefresh: _refreshPage,
                  color: theme.colorScheme.primary,
                  backgroundColor: theme.cardColor,
                  strokeWidth: 3,
                  displacement: 55,
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
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

/// Loads a deferred library the first time a page is opened, then shows it.
class _DeferredScreen extends StatefulWidget {
  final Future<void> Function() loadLibrary;
  final WidgetBuilder builder;

  const _DeferredScreen({
    required this.loadLibrary,
    required this.builder,
  });

  @override
  State<_DeferredScreen> createState() => _DeferredScreenState();
}

class _DeferredScreenState extends State<_DeferredScreen> {
  late final Future<void> _future = widget.loadLibrary();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Could not load this page. Please refresh and try again.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return widget.builder(context);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
