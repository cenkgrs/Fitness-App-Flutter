import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(AppConstants.splashMinDuration, () {
      if (mounted) context.go('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
                children: [
                  TextSpan(text: 'THRIVE', style: TextStyle(color: AppColors.textPrimary)),
                  TextSpan(text: '+', style: TextStyle(color: AppColors.primary)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.splashTagline,
                style: AppTypography.bodyMd.copyWith(color: AppColors.textTertiary)),
          ],
        ),
      ),
    );
  }
}
