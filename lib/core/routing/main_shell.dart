import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';

/// Bottom navigation shell wrapping the 5 primary tabs, per spec section
/// "EKRAN 15: BOTTOM NAVIGATION BAR". The selected tab swaps to the filled
/// icon weight instead of relying on color alone.
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    BottomNavigationBarItem item(IconData icon, IconData activeIcon, String label) =>
        BottomNavigationBarItem(icon: Icon(icon), activeIcon: Icon(activeIcon), label: label);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(top: BorderSide(color: AppColors.surfaceBorder)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
              items: [
                item(AppIcons.house, AppIcons.houseFill, l10n.navHome),
                item(AppIcons.barbell, AppIcons.barbellFill, l10n.navWorkouts),
                item(AppIcons.forkKnife, AppIcons.forkKnifeFill, l10n.navNutrition),
                item(AppIcons.chartLineUp, AppIcons.chartLineUpFill, l10n.navProgress),
                item(AppIcons.user, AppIcons.userFill, l10n.navProfile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
