
import 'package:flutter/material.dart';

class PortfolioNavbar extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onNavigate;

  const PortfolioNavbar({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onNavigate,
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
                PopupMenuButton<String>(
                  tooltip: 'Open navigation menu',
                  icon: Icon(
                    Icons.menu,
                    color: colors.onSurface,
                    size: 28,
                  ),
                  onSelected: onNavigate,
                  itemBuilder: (context) => navItems
                      .map(
                        (item) => PopupMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
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
      onTap: () => onNavigate('Home'),
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
