import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/social_data.dart';

class PortfolioNavbar extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onNavigate;
  final VoidCallback onLogoTap;

  const PortfolioNavbar({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onNavigate,
    required this.onLogoTap,
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

  Future<void> _openSocialLink(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _openMobileDrawer(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final colors = Theme.of(context).colorScheme;

    showGeneralDialog<void>(
      context: context,
      barrierLabel: 'Navigation menu',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.55),
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Theme.of(dialogContext).scaffoldBackgroundColor,
            elevation: 20,
            child: SafeArea(
              child: SizedBox(
                width: screenWidth < 420 ? screenWidth * 0.86 : 360,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 22, 16, 22),
                      child: Row(
                        children: [
                          Container(
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
                          const SizedBox(width: 13),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jahangir Alam',
                                  style: TextStyle(
                                    color: colors.onSurface,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Flutter Developer',
                                  style: TextStyle(
                                    color: colors.onSurface.withOpacity(0.6),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: 'Close menu',
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            icon: Icon(Icons.close, color: colors.onSurface),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: colors.outline.withOpacity(0.18),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                      child: Text(
                        'MENU',
                        style: TextStyle(
                          color: colors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.8,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: navItems.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 3),
                        itemBuilder: (context, index) {
                          final item = navItems[index];
                          final icons = [
                            Icons.home_rounded,
                            Icons.person_outline_rounded,
                            Icons.auto_awesome_outlined,
                            Icons.design_services_outlined,
                            Icons.work_outline_rounded,
                            Icons.bolt_rounded,
                            Icons.mail_outline_rounded,
                          ];

                          return ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            leading: Icon(
                              icons[index],
                              color: colors.primary,
                              size: 21,
                            ),
                            title: Text(
                              item,
                              style: TextStyle(
                                color: colors.onSurface,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: colors.onSurface.withOpacity(0.38),
                            ),
                            onTap: () {
                              Navigator.of(dialogContext).pop();
                              onNavigate(item);
                            },
                          );
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: colors.outline.withOpacity(0.18),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 18, 24, 10),
                      child: Text(
                        'CONNECT WITH ME',
                        style: TextStyle(
                          color: colors.onSurface.withOpacity(0.58),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: socialData
                            .where((item) =>
                                item.name != 'Email' &&
                                item.name != 'WhatsApp')
                            .map(
                              (item) => Tooltip(
                                message: item.name,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () => _openSocialLink(item.url),
                                  child: Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: colors.primary.withOpacity(0.10),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      item.icon,
                                      color: colors.primary,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }

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
                const SizedBox(width: 4),
                IconButton(
                  tooltip: 'Open navigation menu',
                  onPressed: () => _openMobileDrawer(context),
                  icon: Icon(
                    Icons.menu_rounded,
                    color: colors.onSurface,
                    size: 29,
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
      onTap: onLogoTap,
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
