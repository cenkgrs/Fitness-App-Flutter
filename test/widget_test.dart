import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:repwise/main.dart';

/// Box names mirror lib/shared/services/local_storage_service.dart, which
/// keeps them private — duplicated here since production code doesn't
/// initialize Hive with a widget-test-friendly temp directory.
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
    tempDir = await Directory.systemTemp.createTemp('repwise_test');
    Hive.init(tempDir.path);
    await Future.wait(_boxNames.map(Hive.openBox));
  });

  tearDownAll(() async {
    await Hive.close();
    if (await tempDir.exists()) await tempDir.delete(recursive: true);
  });

  testWidgets('App boots through the splash screen into auth (login comes before onboarding)',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: RepwiseApp()));
    await tester.pump();

    expect(find.text('Train smarter. Get stronger.'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pumpAndSettle();

    expect(find.text('Hesap Oluştur'), findsOneWidget);
  });
}
