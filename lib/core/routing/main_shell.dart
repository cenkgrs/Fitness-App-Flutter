import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_colors.dart';

/// Bottom navigation shell wrapping the 5 primary tabs, per spec section
/// "EKRAN 15: BOTTOM NAVIGATION BAR".
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
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
                BottomNavigationBarItem(icon: const Icon(Icons.dashboard_rounded), label: l10n.navHome),
                BottomNavigationBarItem(icon: const Icon(Icons.fitness_center_rounded), label: l10n.navWorkouts),
                BottomNavigationBarItem(icon: const Icon(Icons.restaurant_rounded), label: l10n.navNutrition),
                BottomNavigationBarItem(icon: const Icon(Icons.insights_rounded), label: l10n.navProgress),
                BottomNavigationBarItem(icon: const Icon(Icons.person_rounded), label: l10n.navProfile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
