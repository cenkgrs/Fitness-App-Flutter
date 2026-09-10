import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/models.dart';
import '../../../../shared/services/nutrition_calculator.dart';
import '../controllers/onboarding_controller.dart';

const _totalDataSteps = 13; // steps 1..13 (excludes welcome/calculating/plan-ready)

class OnboardingFlowScreen extends ConsumerStatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  ConsumerState<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends ConsumerState<OnboardingFlowScreen> {
  int _step = 0;
  static const _lastStep = 15;

  void _next() {
    if (_step >= _lastStep) return;
    setState(() => _step++);
    if (_step == 14) {
      Future.delayed(const Duration(milliseconds: 2200), () {
        if (mounted) setState(() => _step = 15);
      });
    }
  }

  void _back() {
    if (_step == 0) return;
    setState(() => _step--);
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(onboardingControllerProvider);
    final notifier = ref.read(onboardingControllerProvider.notifier);

    final showProgress = _step >= 1 && _step <= 13;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (_step > 0 && _step < 14)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.textSecondary),
                      onPressed: _back,
                    ),
                    if (showProgress)
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: LinearProgressIndicator(
                            value: _step / _totalDataSteps,
                            minHeight: 3,
                            backgroundColor: AppColors.surface2,
                            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.screenMargin),
                child: _buildStep(context, draft, notifier),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, OnboardingDraft draft, OnboardingController notifier) {
    final l10n = AppLocalizations.of(context)!;
    switch (_step) {
      case 0:
        return _WelcomeStep(onNext: _next);
      case 1:
        return _NameStep(value: draft.name, onNext: _next, onChanged: (v) => notifier.update((d) => d.copyWith(name: v)));
      case 2:
        return _GenderStep(
          value: draft.gender,
          onSelect: (g) {
            notifier.update((d) => d.copyWith(gender: g));
            _next();
          },
        );
      case 3:
        return _NumberWheelStep(
          title: l10n.onboardingAgeTitle,
          value: draft.age.toDouble(),
          min: 14,
          max: 90,
          step: 1,
          suffix: '',
          onChanged: (v) => notifier.update((d) => d.copyWith(age: v.round())),
          onNext: _next,
        );
      case 4:
        return _NumberWheelStep(
          title: l10n.onboardingHeightTitle,
          value: draft.heightCm,
          min: 130,
          max: 220,
          step: 1,
          suffix: ' cm',
          onChanged: (v) => notifier.update((d) => d.copyWith(heightCm: v)),
          onNext: _next,
        );
      case 5:
        return _NumberWheelStep(
          title: l10n.onboardingWeightTitle,
          value: draft.weightKg,
          min: 35,
          max: 200,
          step: 0.5,
          suffix: ' kg',
          onChanged: (v) => notifier.update((d) => d.copyWith(weightKg: v)),
          onNext: _next,
        );
      case 6:
        return _NumberWheelStep(
          title: l10n.onboardingTargetWeightTitle,
          value: draft.targetWeightKg,
          min: 35,
          max: 200,
          step: 0.5,
          suffix: ' kg',
          delta: draft.targetWeightKg - draft.weightKg,
          onChanged: (v) => notifier.update((d) => d.copyWith(targetWeightKg: v)),
          onNext: _next,
        );
      case 7:
        return _FitnessLevelStep(
          value: draft.fitnessLevel,
          onSelect: (v) {
            notifier.update((d) => d.copyWith(fitnessLevel: v));
            _next();
          },
        );
      case 8:
        return _PrimaryGoalStep(
          value: draft.primaryGoal,
          onSelect: (v) {
            notifier.update((d) => d.copyWith(primaryGoal: v));
            _next();
          },
        );
      case 9:
        return _PillChoiceStep<int>(
          title: l10n.onboardingDaysPerWeekTitle,
          options: const [2, 3, 4, 5, 6],
          labelBuilder: (v) => '$v',
          badge: 4,
          badgeLabel: l10n.onboardingMostPopular,
          value: draft.workoutDaysPerWeek,
          onSelect: (v) {
            notifier.update((d) => d.copyWith(workoutDaysPerWeek: v));
            _next();
          },
        );
      case 10:
        return _PillChoiceStep<int>(
          title: l10n.onboardingDurationTitle,
          options: const [20, 30, 45, 60, 90],
          labelBuilder: (v) => l10n.onboardingDurationMinutes(v),
          value: draft.workoutDurationMinutes,
          onSelect: (v) {
            notifier.update((d) => d.copyWith(workoutDurationMinutes: v));
            _next();
          },
        );
      case 11:
        return _LocationEquipmentStep(
          location: draft.workoutLocation,
          equipment: draft.availableEquipment,
          onLocationChanged: (v) => notifier.update((d) => d.copyWith(workoutLocation: v)),
          onEquipmentChanged: (v) => notifier.update((d) => d.copyWith(availableEquipment: v)),
          onNext: _next,
        );
      case 12:
        return _ActivityLevelStep(
          value: draft.activityLevel,
          onSelect: (v) {
            notifier.update((d) => d.copyWith(activityLevel: v));
            _next();
          },
        );
      case 13:
        return _NutritionPreferenceStep(
          value: draft.nutritionPreference,
          onSelect: (v) {
            notifier.update((d) => d.copyWith(nutritionPreference: v));
            _next();
          },
        );
      case 14:
        return const _CalculatingStep();
      default:
        return _PlanReadyStep(draft: draft);
    }
  }
}

class _StepScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? footer;

  const _StepScaffold({required this.title, this.subtitle, required this.child, this.footer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.headingLg),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle!, style: AppTypography.bodyMd),
        ],
        const SizedBox(height: AppSpacing.xl),
        Expanded(child: child),
        if (footer != null) footer!,
      ],
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  final VoidCallback onNext;
  const _WelcomeStep({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const Icon(Icons.bolt, color: AppColors.primary, size: 64),
        const SizedBox(height: AppSpacing.xl),
        Text(l10n.onboardingWelcomeHeadline, style: AppTypography.headingLg, textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.onboardingWelcomeSubtitle,
          style: AppTypography.bodyMd,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        PrimaryButton(label: l10n.onboardingGetStarted, onPressed: onNext),
      ],
    );
  }
}

class _NameStep extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final VoidCallback onNext;
  const _NameStep({required this.value, required this.onChanged, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _StepScaffold(
      title: l10n.onboardingNameTitle,
      child: Align(
        alignment: Alignment.topCenter,
        child: TextField(
          autofocus: true,
          textAlign: TextAlign.center,
          style: AppTypography.headingMd,
          controller: TextEditingController(text: value)
            ..selection = TextSelection.collapsed(offset: value.length),
          onChanged: onChanged,
          decoration: InputDecoration(hintText: l10n.onboardingNameHint),
        ),
      ),
      footer: PrimaryButton(label: l10n.onboardingContinue, onPressed: value.trim().isEmpty ? null : onNext),
    );
  }
}

class _GenderStep extends StatelessWidget {
  final Gender value;
  final ValueChanged<Gender> onSelect;
  const _GenderStep({required this.value, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _StepScaffold(
      title: l10n.onboardingGenderTitle,
      child: Column(
        children: [
          _ChoiceCard(label: l10n.onboardingGenderMale, icon: Icons.male, selected: value == Gender.male, onTap: () => onSelect(Gender.male)),
          const SizedBox(height: AppSpacing.md),
          _ChoiceCard(label: l10n.onboardingGenderFemale, icon: Icons.female, selected: value == Gender.female, onTap: () => onSelect(Gender.female)),
          const SizedBox(height: AppSpacing.md),
          _ChoiceCard(
              label: l10n.onboardingGenderUnspecified,
              icon: Icons.person,
              selected: value == Gender.unspecified,
              onTap: () => onSelect(Gender.unspecified)),
        ],
      ),
    );
  }
}

class _NumberWheelStep extends StatelessWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final double step;
  final String suffix;
  final double? delta;
  final ValueChanged<double> onChanged;
  final VoidCallback onNext;

  const _NumberWheelStep({
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    required this.suffix,
    this.delta,
    required this.onChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      title: title,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${value.toStringAsFixed(step < 1 ? 1 : 0)}$suffix', style: AppTypography.displayLg),
            if (delta != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${delta! >= 0 ? '+' : ''}${delta!.toStringAsFixed(1)} kg',
                style: AppTypography.bodyMd.copyWith(color: AppColors.primary),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _WheelButton(icon: Icons.remove, onTap: () => onChanged((value - step).clamp(min, max))),
                const SizedBox(width: AppSpacing.xl),
                _WheelButton(icon: Icons.add, onTap: () => onChanged((value + step).clamp(min, max))),
              ],
            ),
          ],
        ),
      ),
      footer: PrimaryButton(label: AppLocalizations.of(context)!.onboardingContinue, onPressed: onNext),
    );
  }
}

class _WheelButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _WheelButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface2,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(width: 56, height: 56, child: Icon(icon, color: AppColors.textPrimary)),
      ),
    );
  }
}

class _FitnessLevelStep extends StatelessWidget {
  final FitnessLevel value;
  final ValueChanged<FitnessLevel> onSelect;
  const _FitnessLevelStep({required this.value, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _StepScaffold(
      title: l10n.onboardingFitnessLevelTitle,
      child: Column(
        children: [
          _ChoiceCard(
              label: l10n.fitnessBeginnerLabel,
              subtitle: l10n.fitnessBeginnerSubtitle,
              selected: value == FitnessLevel.beginner,
              onTap: () => onSelect(FitnessLevel.beginner)),
          const SizedBox(height: AppSpacing.md),
          _ChoiceCard(
              label: l10n.fitnessIntermediateLabel,
              subtitle: l10n.fitnessIntermediateSubtitle,
              selected: value == FitnessLevel.intermediate,
              onTap: () => onSelect(FitnessLevel.intermediate)),
          const SizedBox(height: AppSpacing.md),
          _ChoiceCard(
              label: l10n.fitnessAdvancedLabel,
              subtitle: l10n.fitnessAdvancedSubtitle,
              selected: value == FitnessLevel.advanced,
              onTap: () => onSelect(FitnessLevel.advanced)),
        ],
      ),
    );
  }
}

class _PrimaryGoalStep extends StatelessWidget {
  final PrimaryGoal value;
  final ValueChanged<PrimaryGoal> onSelect;
  const _PrimaryGoalStep({required this.value, required this.onSelect});

  Map<PrimaryGoal, String> _labels(AppLocalizations l10n) => {
        PrimaryGoal.loseWeight: l10n.goalLoseWeight,
        PrimaryGoal.buildMuscle: l10n.goalBuildMuscle,
        PrimaryGoal.loseFat: l10n.goalLoseFat,
        PrimaryGoal.maintainFitness: l10n.goalMaintainFitness,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _StepScaffold(
      title: l10n.onboardingPrimaryGoalTitle,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.1,
        children: _labels(l10n)
            .entries
            .map((e) => _ChoiceCard(
                  label: e.value,
                  selected: value == e.key,
                  onTap: () => onSelect(e.key),
                  compact: true,
                ))
            .toList(),
      ),
    );
  }
}

class _PillChoiceStep<T> extends StatelessWidget {
  final String title;
  final List<T> options;
  final String Function(T) labelBuilder;
  final T value;
  final ValueChanged<T> onSelect;
  final T? badge;
  final String? badgeLabel;

  const _PillChoiceStep({
    required this.title,
    required this.options,
    required this.labelBuilder,
    required this.value,
    required this.onSelect,
    this.badge,
    this.badgeLabel,
  });

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      title: title,
      child: Wrap(
        spacing: AppSpacing.md,
        runSpacing: AppSpacing.md,
        children: options.map((o) {
          final selected = o == value;
          return Column(
            children: [
              GestureDetector(
                onTap: () => onSelect(o),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.surface1,
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(color: selected ? AppColors.primary : AppColors.surfaceBorder),
                  ),
                  child: Text(
                    labelBuilder(o),
                    style: AppTypography.button.copyWith(
                      color: selected ? AppColors.onPrimary : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              if (badge == o && badgeLabel != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(badgeLabel!, style: AppTypography.caption.copyWith(color: AppColors.primary)),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _LocationEquipmentStep extends StatelessWidget {
  final WorkoutLocation location;
  final List<Equipment> equipment;
  final ValueChanged<WorkoutLocation> onLocationChanged;
  final ValueChanged<List<Equipment>> onEquipmentChanged;
  final VoidCallback onNext;

  const _LocationEquipmentStep({
    required this.location,
    required this.equipment,
    required this.onLocationChanged,
    required this.onEquipmentChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _StepScaffold(
      title: l10n.onboardingLocationTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: WorkoutLocation.values.map((loc) {
                final selected = loc == location;
                final label = switch (loc) {
                  WorkoutLocation.gym => l10n.locationGym,
                  WorkoutLocation.home => l10n.locationHome,
                  WorkoutLocation.both => l10n.locationBoth,
                };
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: _ChoiceCard(label: label, selected: selected, compact: true, onTap: () => onLocationChanged(loc)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(l10n.onboardingEquipmentLabel, style: AppTypography.headingSm),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: Equipment.values.map((eq) {
                final selected = equipment.contains(eq);
                return FilterChip(
                  label: Text(eq.name),
                  selected: selected,
                  onSelected: (_) {
                    final next = List<Equipment>.from(equipment);
                    selected ? next.remove(eq) : next.add(eq);
                    onEquipmentChanged(next);
                  },
                  selectedColor: AppColors.primarySoft,
                  checkmarkColor: AppColors.primary,
                  backgroundColor: AppColors.surface2,
                );
              }).toList(),
            ),
          ],
        ),
      ),
      footer: PrimaryButton(label: l10n.onboardingContinue, onPressed: onNext),
    );
  }
}

class _ActivityLevelStep extends StatelessWidget {
  final ActivityLevel value;
  final ValueChanged<ActivityLevel> onSelect;
  const _ActivityLevelStep({required this.value, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _StepScaffold(
      title: l10n.onboardingActivityLevelTitle,
      child: Column(
        children: [
          _ChoiceCard(
              label: l10n.activitySedentaryLabel,
              subtitle: l10n.activitySedentarySubtitle,
              selected: value == ActivityLevel.sedentary,
              onTap: () => onSelect(ActivityLevel.sedentary)),
          const SizedBox(height: AppSpacing.md),
          _ChoiceCard(
              label: l10n.activityModeratelyActiveLabel,
              subtitle: l10n.activityModeratelyActiveSubtitle,
              selected: value == ActivityLevel.moderatelyActive,
              onTap: () => onSelect(ActivityLevel.moderatelyActive)),
          const SizedBox(height: AppSpacing.md),
          _ChoiceCard(
              label: l10n.activityVeryActiveLabel,
              subtitle: l10n.activityVeryActiveSubtitle,
              selected: value == ActivityLevel.veryActive,
              onTap: () => onSelect(ActivityLevel.veryActive)),
        ],
      ),
    );
  }
}

class _NutritionPreferenceStep extends StatelessWidget {
  final NutritionPreference value;
  final ValueChanged<NutritionPreference> onSelect;
  const _NutritionPreferenceStep({required this.value, required this.onSelect});

  Map<NutritionPreference, String> _labels(AppLocalizations l10n) => {
        NutritionPreference.standard: l10n.nutritionStandard,
        NutritionPreference.highProtein: l10n.nutritionHighProtein,
        NutritionPreference.keto: l10n.nutritionKeto,
        NutritionPreference.vegetarian: l10n.nutritionVegetarian,
        NutritionPreference.vegan: l10n.nutritionVegan,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _StepScaffold(
      title: l10n.onboardingNutritionPrefTitle,
      child: ListView(
        children: _labels(l10n)
            .entries
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _ChoiceCard(label: e.value, selected: value == e.key, onTap: () => onSelect(e.key)),
                ))
            .toList(),
      ),
    );
  }
}

class _CalculatingStep extends StatelessWidget {
  const _CalculatingStep();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.onboardingCalculatingLine1, style: AppTypography.bodyLg, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.onboardingCalculatingLine2, style: AppTypography.bodyMd, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _PlanReadyStep extends ConsumerWidget {
  final OnboardingDraft draft;
  const _PlanReadyStep({required this.draft});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final macros = const NutritionCalculator().calculate(draft.toProfile('local'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.check_circle, color: AppColors.success),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                l10n.onboardingPlanReadyTitle(draft.name.isEmpty ? l10n.onboardingDefaultName : draft.name),
                style: AppTypography.headingLg,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        Expanded(
          child: SingleChildScrollView(
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${macros.calories} kcal', style: AppTypography.displayMd.copyWith(color: AppColors.primary)),
                  Text(l10n.onboardingDailyCalories, style: AppTypography.caption),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(child: _MacroChip(label: l10n.macroProtein, value: '${macros.proteinG}g', color: AppColors.protein)),
                      Expanded(child: _MacroChip(label: l10n.macroCarbs, value: '${macros.carbsG}g', color: AppColors.carbs)),
                      Expanded(child: _MacroChip(label: l10n.macroFat, value: '${macros.fatG}g', color: AppColors.fat)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const Divider(),
                  const SizedBox(height: AppSpacing.md),
                  Text(l10n.onboardingDaysPerWeekProgram(draft.workoutDaysPerWeek), style: AppTypography.bodyLg),
                  const SizedBox(height: AppSpacing.xs),
                  Text(l10n.onboardingPlanTagline, style: AppTypography.bodyMd),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: l10n.onboardingStartMyPlan,
          onPressed: () async {
            await ref.read(onboardingControllerProvider.notifier).completeOnboarding();
            if (context.mounted) context.go('/home');
          },
        ),
      ],
    );
  }
}

class _MacroChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MacroChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: AppTypography.headingSm.copyWith(color: color)),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  final String label;
  final String? subtitle;
  final IconData? icon;
  final bool selected;
  final bool compact;
  final VoidCallback onTap;

  const _ChoiceCard({
    required this.label,
    this.subtitle,
    this.icon,
    required this.selected,
    this.compact = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
        decoration: BoxDecoration(
          color: selected ? AppColors.primarySoft : AppColors.surface1,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? AppColors.primary : AppColors.surfaceBorder, width: selected ? 1.5 : 1),
        ),
        child: Column(
          crossAxisAlignment: compact ? CrossAxisAlignment.start : CrossAxisAlignment.start,
          mainAxisAlignment: compact ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[Icon(icon, color: selected ? AppColors.primary : AppColors.textSecondary), const SizedBox(width: AppSpacing.sm)],
                Expanded(child: Text(label, style: AppTypography.bodyLg)),
                if (selected) const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(subtitle!, style: AppTypography.caption),
            ],
          ],
        ),
      ),
    );
  }
}
