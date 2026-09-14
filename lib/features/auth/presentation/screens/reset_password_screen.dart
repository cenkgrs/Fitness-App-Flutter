import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/auth_controller.dart';

/// Reached only via a password-recovery deep link (see [passwordRecoveryProvider]
/// and the router redirect in app_router.dart) — lets the user set a new
/// password for the session Supabase already established from that link.
class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    if (_password.text.length < 6) return;
    await ref.read(authControllerProvider.notifier).updatePassword(_password.text);
    if (!mounted) return;
    final state = ref.read(authControllerProvider);
    if (!state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.authNewPasswordSuccess)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.authErrorSnackbar(next.error.toString()))),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.authNewPasswordTitle, style: AppTypography.headingLg),
              const SizedBox(height: AppSpacing.xl),
              TextField(
                controller: _password,
                obscureText: _obscure,
                style: AppTypography.bodyLg,
                decoration: InputDecoration(
                  hintText: l10n.authNewPasswordHint,
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: l10n.authNewPasswordButton,
                isLoading: authState.isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
