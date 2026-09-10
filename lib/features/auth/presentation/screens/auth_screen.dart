import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/auth_controller.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _isSignUp = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    ref.listen(authControllerProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.authErrorSnackbar(next.error.toString()))),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xxl),
              Text(_isSignUp ? l10n.authSignUpTitle : l10n.authSignInTitle,
                  style: AppTypography.headingLg),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _isSignUp ? l10n.authSignUpSubtitle : l10n.authSignInSubtitle,
                style: AppTypography.bodyMd,
              ),
              const SizedBox(height: AppSpacing.xxl),
              SecondaryButton(
                label: l10n.authContinueWithApple,
                icon: Icons.apple,
                onPressed: isLoading ? null : () => ref.read(authControllerProvider.notifier).signInWithApple(),
              ),
              const SizedBox(height: AppSpacing.md),
              SecondaryButton(
                label: l10n.authContinueWithGoogle,
                icon: Icons.g_mobiledata,
                onPressed: isLoading ? null : () => ref.read(authControllerProvider.notifier).signInWithGoogle(),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Text(l10n.authOrWithEmail, style: AppTypography.caption),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: AppTypography.bodyLg,
                decoration: InputDecoration(hintText: l10n.authEmailHint),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _passwordController,
                obscureText: _obscure,
                style: AppTypography.bodyLg,
                decoration: InputDecoration(
                  hintText: l10n.authPasswordHint,
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.textTertiary),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: _isSignUp ? l10n.authSignUpButton : l10n.authSignInButton,
                isLoading: isLoading,
                onPressed: () {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text;
                  if (email.isEmpty || password.isEmpty) return;
                  if (_isSignUp) {
                    ref.read(authControllerProvider.notifier).signUpWithEmail(email, password);
                  } else {
                    ref.read(authControllerProvider.notifier).signInWithEmail(email, password);
                  }
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: TextButton(
                  onPressed: () => setState(() => _isSignUp = !_isSignUp),
                  child: Text(_isSignUp ? l10n.authSwitchToSignIn : l10n.authSwitchToSignUp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
