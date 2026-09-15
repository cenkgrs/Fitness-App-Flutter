import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/ai/ai_providers.dart';
import '../../../../shared/models/models.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../../subscription/presentation/controllers/subscription_gate.dart';
import '../controllers/nutrition_providers.dart';
import 'barcode_scanner_screen.dart';

class FoodLoggerScreen extends ConsumerStatefulWidget {
  final String mealType;
  const FoodLoggerScreen({super.key, required this.mealType});

  @override
  ConsumerState<FoodLoggerScreen> createState() => _FoodLoggerScreenState();
}

class _FoodLoggerScreenState extends ConsumerState<FoodLoggerScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);
  final _searchController = TextEditingController();
  List<Food> _results = const [];
  Timer? _debounce;

  MealType get _type => MealType.values.firstWhere((t) => t.name == widget.mealType);

  @override
  void initState() {
    super.initState();
    _search('');
  }

  /// Debounced: search now hits a live external API (Open Food Facts), not
  /// just local Hive, so firing on every keystroke would spam it.
  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () => _search(query));
  }

  Future<void> _search(String query) async {
    final country = ref.read(settingsControllerProvider).foodSearchCountry;
    final results =
        await ref.read(nutritionRepositoryProvider).searchFoods(query, country: country);
    if (mounted) setState(() => _results = results);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _addEntry(MealEntry entry) => _addEntries([entry]);

  /// Batch add so an AI-parsed free-text meal (which can produce several
  /// entries at once, e.g. "3 eggs, 100g rice, salad") is saved as one meal
  /// update instead of racing multiple read-modify-write calls.
  Future<void> _addEntries(List<MealEntry> entries) async {
    final userId = ref.read(authStateProvider).valueOrNull?.id ?? 'local';
    final date = ref.read(selectedNutritionDateProvider);
    final repo = ref.read(nutritionRepositoryProvider);
    final existingMeals = await repo.getMealsForDate(userId, date);
    Meal? existing;
    for (final m in existingMeals) {
      if (m.type == _type) existing = m;
    }
    final meal = existing?.copyWith(entries: [...existing.entries, ...entries]) ??
        Meal(id: const Uuid().v4(), userId: userId, date: date, type: _type, entries: entries);
    await repo.saveMeal(meal);
    ref.invalidate(dailyNutritionProvider);
    if (mounted) context.pop();
  }

  String _mealTypeLabel(AppLocalizations l10n, MealType type) => switch (type) {
        MealType.breakfast => l10n.mealTypeBreakfast,
        MealType.lunch => l10n.mealTypeLunch,
        MealType.dinner => l10n.mealTypeDinner,
        MealType.snack => l10n.mealTypeSnack,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.foodLoggerTitle(_mealTypeLabel(l10n, _type))),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: l10n.barcodeScannerTitle,
            onPressed: _scanBarcode,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          indicatorColor: AppColors.primary,
          tabs: [Tab(text: l10n.foodLoggerSearchTab), Tab(text: l10n.foodLoggerQuickAddTab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _SearchTab(
            searchController: _searchController,
            results: _results,
            onSearch: _onSearchChanged,
            onSelectFood: (food) => _showQuantitySheet(food),
          ),
          _QuickAddTab(onSave: _addEntries),
        ],
      ),
    );
  }

  Future<void> _scanBarcode() async {
    final l10n = AppLocalizations.of(context)!;
    final barcode = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const BarcodeScannerScreen()),
    );
    if (barcode == null || !mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
    final food = await ref.read(nutritionRepositoryProvider).getFoodByBarcode(barcode);
    if (!mounted) return;
    Navigator.pop(context); // close loading dialog

    if (food == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.barcodeScannerNotFound)),
      );
      return;
    }
    _showQuantitySheet(food);
  }

  void _showQuantitySheet(Food food) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface1,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => _QuantitySheet(
        food: food,
        onConfirm: (entry) {
          Navigator.pop(ctx);
          _addEntry(entry);
        },
      ),
    );
  }
}

class _SearchTab extends StatelessWidget {
  final TextEditingController searchController;
  final List<Food> results;
  final ValueChanged<String> onSearch;
  final ValueChanged<Food> onSelectFood;

  const _SearchTab({
    required this.searchController,
    required this.results,
    required this.onSearch,
    required this.onSelectFood,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.screenMargin),
          child: TextField(
            controller: searchController,
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: l10n.foodLoggerSearchHint,
              prefixIcon: const Icon(Icons.search, color: AppColors.textTertiary),
            ),
          ),
        ),
        Expanded(
          child: results.isEmpty
              ? EmptyState(
                  icon: Icons.search_off,
                  title: l10n.foodLoggerNoResultsTitle,
                  message: l10n.foodLoggerNoResultsMessage)
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                  itemCount: results.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final food = results[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(food.name, style: AppTypography.bodyLg),
                      subtitle: Text(
                        l10n.foodLoggerNutritionSummary(
                          food.caloriesPer100g.round().toString(),
                          food.proteinPer100g.round().toString(),
                          food.carbsPer100g.round().toString(),
                          food.fatPer100g.round().toString(),
                        ),
                        style: AppTypography.caption,
                      ),
                      trailing: const Icon(Icons.chevron_right, color: AppColors.textTertiary),
                      onTap: () => onSelectFood(food),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _QuantitySheet extends StatefulWidget {
  final Food food;
  final ValueChanged<MealEntry> onConfirm;
  const _QuantitySheet({required this.food, required this.onConfirm});

  @override
  State<_QuantitySheet> createState() => _QuantitySheetState();
}

class _QuantitySheetState extends State<_QuantitySheet> {
  double _grams = 100;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final f = widget.food;
    final ratio = _grams / 100;
    final calories = f.caloriesPer100g * ratio;
    final protein = f.proteinPer100g * ratio;
    final carbs = f.carbsPer100g * ratio;
    final fat = f.fatPer100g * ratio;

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.xl,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(f.name, style: AppTypography.headingMd),
          const SizedBox(height: AppSpacing.lg),
          Text('${_grams.round()} g', style: AppTypography.displayMd, textAlign: TextAlign.center)
              .let((w) => Center(child: w)),
          Wrap(
            spacing: AppSpacing.sm,
            children: [50, 100, 150, 200].map((g) {
              return ChoiceChip(
                label: Text('${g}g'),
                selected: _grams == g,
                onSelected: (_) => setState(() => _grams = g.toDouble()),
                selectedColor: AppColors.primarySoft,
                backgroundColor: AppColors.surface2,
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
              l10n.foodLoggerQuantitySummary(calories.round().toString(), protein.round().toString(),
                  carbs.round().toString(), fat.round().toString()),
              style: AppTypography.bodyMd),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: l10n.commonAdd,
            onPressed: () => widget.onConfirm(MealEntry(
              id: const Uuid().v4(),
              foodId: f.id,
              name: f.name,
              quantityGrams: _grams,
              calories: calories,
              proteinG: protein,
              carbsG: carbs,
              fatG: fat,
            )),
          ),
        ],
      ),
    );
  }
}

class _QuickAddTab extends ConsumerStatefulWidget {
  final Future<void> Function(List<MealEntry> entries) onSave;
  const _QuickAddTab({required this.onSave});

  @override
  ConsumerState<_QuickAddTab> createState() => _QuickAddTabState();
}

class _QuickAddTabState extends ConsumerState<_QuickAddTab> {
  final _calories = TextEditingController();
  final _protein = TextEditingController();
  final _carbs = TextEditingController();
  final _fat = TextEditingController();
  final _aiText = TextEditingController();
  bool _aiLoading = false;

  @override
  void dispose() {
    _calories.dispose();
    _protein.dispose();
    _carbs.dispose();
    _fat.dispose();
    _aiText.dispose();
    super.dispose();
  }

  Future<void> _fillWithAI() async {
    final l10n = AppLocalizations.of(context)!;
    final parser = ref.read(aiFoodParserProvider);
    if (parser == null || _aiText.text.trim().isEmpty) return;
    if (!await requirePremium(context, ref)) return;
    setState(() => _aiLoading = true);
    try {
      final entries = await parser.parseMealText(_aiText.text.trim());
      if (entries.isEmpty) return;
      await widget.onSave(entries);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.foodLoggerAiParseFailedSnackbar(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _aiLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final aiAvailable = ref.watch(aiFoodParserProvider) != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (aiAvailable) ...[
            TextField(
              controller: _aiText,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: l10n.foodLoggerAiHint,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SecondaryButton(
              label: _aiLoading ? l10n.foodLoggerAiParsing : l10n.foodLoggerAiFillButton,
              icon: Icons.auto_awesome,
              onPressed: _aiLoading ? null : _fillWithAI,
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Text(l10n.foodLoggerOrManualEntry, style: AppTypography.caption),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          _numberField(l10n.quickAddCaloriesLabel, _calories),
          const SizedBox(height: AppSpacing.md),
          _numberField(l10n.quickAddProteinLabel, _protein),
          const SizedBox(height: AppSpacing.md),
          _numberField(l10n.quickAddCarbsLabel, _carbs),
          const SizedBox(height: AppSpacing.md),
          _numberField(l10n.quickAddFatLabel, _fat),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: l10n.commonAdd,
            onPressed: () {
              final calories = double.tryParse(_calories.text) ?? 0;
              if (calories <= 0) return;
              widget.onSave([
                MealEntry(
                  id: const Uuid().v4(),
                  name: l10n.quickAddEntryDefaultName,
                  quantityGrams: 0,
                  calories: calories,
                  proteinG: double.tryParse(_protein.text) ?? 0,
                  carbsG: double.tryParse(_carbs.text) ?? 0,
                  fatG: double.tryParse(_fat.text) ?? 0,
                  isQuickAdd: true,
                ),
              ]);
            },
          ),
        ],
      ),
    );
  }

  Widget _numberField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(hintText: label),
    );
  }
}

extension _Let<T> on T {
  R let<R>(R Function(T) block) => block(this);
}
