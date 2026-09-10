import 'package:equatable/equatable.dart';

/// Authenticated account identity. Distinct from [UserProfile], which
/// holds fitness-specific onboarding data.
class AppUser extends Equatable {
  final String id;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String authProvider; // 'email' | 'google' | 'apple'
  final DateTime createdAt;

  const AppUser({
    required this.id,
    this.email,
    this.displayName,
    this.photoUrl,
    required this.authProvider,
    required this.createdAt,
  });

  AppUser copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    String? authProvider,
    DateTime? createdAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      authProvider: authProvider ?? this.authProvider,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'photoUrl': photoUrl,
        'authProvider': authProvider,
        'createdAt': createdAt.toIso8601String(),
      };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json['id'] as String,
        email: json['email'] as String?,
        displayName: json['displayName'] as String?,
        photoUrl: json['photoUrl'] as String?,
        authProvider: json['authProvider'] as String? ?? 'email',
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  @override
  List<Object?> get props => [id, email, displayName, photoUrl, authProvider, createdAt];
}
