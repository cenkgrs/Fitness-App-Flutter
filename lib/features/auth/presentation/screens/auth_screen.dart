import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
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
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    ref.listen(authControllerProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong: ${next.error}')),
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
              Text(_isSignUp ? 'Save Your Progress' : 'Welcome Back',
                  style: AppTypography.headingLg),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _isSignUp
                    ? 'Kayıt ol ve planını bulutla eşitle.'
                    : 'Giriş yap ve kaldığın yerden devam et.',
                style: AppTypography.bodyMd,
              ),
              const SizedBox(height: AppSpacing.xxl),
              SecondaryButton(
                label: 'Apple ile Devam Et',
                icon: Icons.apple,
                onPressed: isLoading ? null : () => ref.read(authControllerProvider.notifier).signInWithApple(),
              ),
              const SizedBox(height: AppSpacing.md),
              SecondaryButton(
                label: 'Google ile Devam Et',
                icon: Icons.g_mobiledata,
                onPressed: isLoading ? null : () => ref.read(authControllerProvider.notifier).signInWithGoogle(),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Text('veya e-posta ile', style: AppTypography.caption),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: AppTypography.bodyLg,
                decoration: const InputDecoration(hintText: 'E-posta'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _passwordController,
                obscureText: _obscure,
                style: AppTypography.bodyLg,
                decoration: InputDecoration(
                  hintText: 'Şifre',
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.textTertiary),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: _isSignUp ? 'Kayıt Ol' : 'Giriş Yap',
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
                  child: Text(_isSignUp
                      ? 'Zaten hesabın var mı? Giriş Yap'
                      : 'Hesabın yok mu? Kayıt Ol'),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: isLoading ? null : () => ref.read(authControllerProvider.notifier).continueAsGuest(),
                  child: const Text('Misafir olarak devam et'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
