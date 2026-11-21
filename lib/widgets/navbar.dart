import 'package:flutter/material.dart';

class PortfolioNavbar extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onNavigate;
  final VoidCallback onMenuPressed;
  final VoidCallback onLogoPressed;

  const PortfolioNavbar({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onNavigate,
    required this.onMenuPressed,
    required this.onLogoPressed,
  });

  static const List<String> navItems = [
    'Home',
    'About',
    'Skills',
    'Services',
    'Projects',
    'Automation',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 850;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 48,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              bottom: BorderSide(
                color: colors.outline.withOpacity(0.15),
              ),
            ),
          ),
          child: Row(
            children: [
              _buildLogo(context),
              const Spacer(),
              if (!isMobile) ...[
                ...navItems.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      onPressed: () => onNavigate(item),
                      child: Text(
                        item,
                        style: TextStyle(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _buildThemeButton(context),
                const SizedBox(width: 14),
                _buildHireButton(context),
              ] else ...[
                _buildThemeButton(context),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Open navigation menu',
                  onPressed: onMenuPressed,
                  icon: Icon(
                    Icons.menu_rounded,
                    color: colors.onSurface,
                    size: 28,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogo(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onLogoPressed,
      borderRadius: BorderRadius.circular(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Text(
              'JA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Jahangir Alam',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeButton(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return IconButton(
      tooltip: isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
      onPressed: () => onThemeChanged(!isDarkMode),
      icon: Icon(
        isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: colors.onSurface,
      ),
    );
  }

  Widget _buildHireButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onNavigate('Contact'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text('Hire Me'),
    );
  }
}

/// Navigation panel displayed by the Scaffold's end drawer on mobile.
class PortfolioNavigationDrawer extends StatelessWidget {
  final ValueChanged<String> onNavigate;
  final VoidCallback onLogoPressed;

  const PortfolioNavigationDrawer({
    super.key,
    required this.onNavigate,
    required this.onLogoPressed,
  });

  static const List<IconData> _icons = [
    Icons.home_outlined,
    Icons.person_outline_rounded,
    Icons.code_rounded,
    Icons.design_services_outlined,
    Icons.work_outline_rounded,
    Icons.account_tree_outlined,
    Icons.mail_outline_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      width: (screenWidth * 0.86).clamp(260.0, 340.0).toDouble(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 16, 22),
              child: Row(
                children: [
                  InkWell(
                    onTap: onLogoPressed,
                    borderRadius: BorderRadius.circular(13),
                    child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'JA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jahangir Alam',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Flutter Developer',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close navigation menu',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: colors.outlineVariant),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 10),
              child: Text(
                'MENU',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                itemCount: PortfolioNavbar.navItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final item = PortfolioNavbar.navItems[index];

                  return ListTile(
                    leading: Icon(_icons[index], color: colors.primary),
                    title: Text(
                      item,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      onNavigate(item);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 18),
              child: Text(
                '© 2026 Md Jahangir Alam',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
