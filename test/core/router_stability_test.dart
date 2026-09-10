import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:repwise/core/routing/app_router.dart';
import 'package:repwise/features/onboarding/presentation/controllers/onboarding_controller.dart';

const _boxNames = [
  'repwise_user',
  'repwise_profile',
  'repwise_goals',
  'repwise_programs',
  'repwise_sessions',
  'repwise_meals',
  'repwise_weight',
  'repwise_metrics',
  'repwise_settings',
  'repwise_foods',
];

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('repwise_router_test');
    Hive.init(tempDir.path);
    await Future.wait(_boxNames.map(Hive.openBox));
  });

  tearDownAll(() async {
    await Hive.close();
    if (await tempDir.exists()) await tempDir.delete(recursive: true);
  });

  setUp(() async {
    for (final name in _boxNames) {
      await Hive.box(name).clear();
    }
  });

  test('completing onboarding does not recreate the GoRouter instance', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final routerBefore = container.read(routerProvider);

    await container.read(onboardingControllerProvider.notifier).completeOnboarding();

    final routerAfter = container.read(routerProvider);

    // Regression guard: if routerProvider ever goes back to `ref.watch`ing
    // auth/onboarding state directly, completing onboarding recreates the
    // whole GoRouter/Navigator tree, silently resetting any in-progress
    // screen's local state (this is exactly what reset the onboarding
    // flow's step index back to 0 after finishing all 14 steps).
    expect(identical(routerBefore, routerAfter), isTrue);
  });

  test('onboardingCompleteProvider flips synchronously, no AsyncLoading gap', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(onboardingCompleteProvider), isFalse);

    await container.read(onboardingControllerProvider.notifier).completeOnboarding();

    expect(container.read(onboardingCompleteProvider), isTrue);
  });
}
