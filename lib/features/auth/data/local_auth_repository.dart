import 'dart:async';
import 'package:uuid/uuid.dart';
import '../../../shared/models/models.dart';
import '../../../shared/services/local_storage_service.dart';
import '../domain/auth_repository.dart';

/// Local/offline implementation of [AuthRepository]. Simulates network
/// latency and persists the "session" in Hive so the app can run without a
/// backend. Passwords are not validated against a real credential store —
/// this is a placeholder until a real auth backend is wired in.
class LocalAuthRepository implements AuthRepository {
  final LocalStorageService _storage;
  final _controller = StreamController<AppUser?>.broadcast();
  static const _sessionKey = 'current_user';

  LocalAuthRepository(this._storage);

  void _emitCurrent() {
    _controller.add(_readUser());
  }

  AppUser? _readUser() {
    final raw = _storage.userBox.get(_sessionKey);
    if (raw == null) return null;
    return AppUser.fromJson(Map<String, dynamic>.from(raw as Map));
  }

  Future<AppUser> _persistAndReturn(AppUser user) async {
    await _storage.userBox.put(_sessionKey, user.toJson());
    _emitCurrent();
    return user;
  }

  @override
  Stream<AppUser?> authStateChanges() async* {
    // A broadcast StreamController drops any event emitted before a
    // listener subscribes, so seeding the initial value in the constructor
    // (before StreamProvider attaches) silently lost it — authStateProvider
    // then sat in AsyncLoading forever, since nothing else emits until the
    // next sign-in/out. Yielding the current value per-listener, then
    // forwarding the live stream, fixes that.
    yield _readUser();
    yield* _controller.stream;
  }

  @override
  Future<AppUser?> currentUser() async => _readUser();

  @override
  Future<AppUser> signInWithEmail({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final existing = _readUser();
    if (existing != null && existing.email == email) return existing;
    return _persistAndReturn(AppUser(
      id: const Uuid().v4(),
      email: email,
      displayName: email.split('@').first,
      authProvider: 'email',
      createdAt: DateTime.now(),
    ));
  }

  @override
  Future<AppUser> signUpWithEmail({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _persistAndReturn(AppUser(
      id: const Uuid().v4(),
      email: email,
      displayName: email.split('@').first,
      authProvider: 'email',
      createdAt: DateTime.now(),
    ));
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _persistAndReturn(AppUser(
      id: const Uuid().v4(),
      email: 'user@gmail.com',
      displayName: 'Google User',
      authProvider: 'google',
      createdAt: DateTime.now(),
    ));
  }

  @override
  Future<AppUser> signInWithApple() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _persistAndReturn(AppUser(
      id: const Uuid().v4(),
      email: 'user@icloud.com',
      displayName: 'Apple User',
      authProvider: 'apple',
      createdAt: DateTime.now(),
    ));
  }

  @override
  Future<void> signOut() async {
    await _storage.userBox.delete(_sessionKey);
    _emitCurrent();
  }
}
