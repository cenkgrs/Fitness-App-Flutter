import 'dart:io';

import 'package:http/http.dart' show ClientException;
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException;
import '../../../l10n/app_localizations.dart';
import '../domain/auth_repository.dart';

/// Maps auth failures to something a user can act on, instead of showing
/// the raw exception text.
String authErrorMessage(AppLocalizations l10n, Object error) {
  if (error is EmailConfirmationRequired) return l10n.authConfirmEmailSent;
  if (error is AuthException) {
    return switch (error.code) {
      'invalid_credentials' => l10n.authErrorInvalidCredentials,
      'email_not_confirmed' => l10n.authErrorEmailNotConfirmed,
      'user_already_exists' || 'email_exists' => l10n.authErrorUserExists,
      'weak_password' => l10n.authErrorWeakPassword,
      'validation_failed' || 'email_address_invalid' => l10n.authErrorInvalidEmail,
      'over_email_send_rate_limit' || 'over_request_rate_limit' => l10n.authErrorRateLimited,
      _ => l10n.authErrorGeneric,
    };
  }
  if (error is SocketException || error is ClientException) return l10n.authErrorNetwork;
  return l10n.authErrorGeneric;
}
