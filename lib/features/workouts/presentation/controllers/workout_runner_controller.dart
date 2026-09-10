import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../../../core/utils/haptics_helper.dart';
import '../../../../shared/models/models.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/personal_record_detector.dart';
import '../../domain/workout_runner_logic.dart';
import '../../domain/workout_runner_state.dart';
import 'workout_providers.dart';

class WorkoutRunnerNotifier extends StateNotifier<WorkoutRunnerState> {
  final Ref _ref;
  Timer? _ticker;
  static const _tickInterval = Duration(seconds: 1);

  WorkoutRunnerNotifier(this._ref, WorkoutDay day, String userId)
      : super(WorkoutRunnerState.initial(
          day,
          WorkoutSession(
            id: const Uuid().v4(),
            userId: userId,
            workoutDayId: day.id,
            workoutDayName: day.name,
            status: WorkoutSessionStatus.inProgress,
            startedAt: DateTime.now(),
            sets: const [],
          ),
        )) {
    WakelockPlus.enable();
    _ticker = Timer.periodic(_tickInterval, (_) => _onTick());
  }

  void _onTick() {
    final wasResting = state.phase == WorkoutRunnerPhase.resting;
    final secondsLeft = state.restRemaining.inSeconds;
    state = WorkoutRunnerLogic.tick(state, _tickInterval);
    if (wasResting && state.phase == WorkoutRunnerPhase.resting) {
      if (secondsLeft <= 3 && secondsLeft > 0) {
        HapticsHelper.restTimerTick();
      }
    } else if (wasResting && state.phase == WorkoutRunnerPhase.exercising) {
      HapticsHelper.restTimerFinished();
    }
  }

  void completeSet({required double actualWeight, required int actualReps, int? rpe}) {
    state = WorkoutRunnerLogic.completeSet(state, actualWeight: actualWeight, actualReps: actualReps, rpe: rpe);
    HapticsHelper.setCompleted();
    if (state.phase == WorkoutRunnerPhase.finished) {
      _finish();
    }
  }

  void skipRest() => state = WorkoutRunnerLogic.skipRest(state);

  void addRest(Duration delta) => state = WorkoutRunnerLogic.adjustRest(state, delta);

  void togglePause() => state = WorkoutRunnerLogic.togglePause(state);

  void updateDraftWeight(double weight) => state = WorkoutRunnerLogic.updateDraft(state, weight: weight);

  void updateDraftReps(int reps) => state = WorkoutRunnerLogic.updateDraft(state, reps: reps);

  void skipExercise() {
    state = WorkoutRunnerLogic.skipExercise(state);
    if (state.phase == WorkoutRunnerPhase.finished) {
      _finish();
    }
  }

  void addExtraSet() => state = WorkoutRunnerLogic.addExtraSet(state);

  Future<void> _finish() async {
    final priorSessions = await _ref.read(workoutRepositoryProvider).getSessions(state.session.userId);
    final prSetIds = detectPersonalRecordSetIds(
      priorSessions: priorSessions,
      currentSession: state.session,
    );

    final finalSession = state.session.copyWith(personalRecordSetIds: prSetIds);
    state = state.copyWith(session: finalSession);
    await _ref.read(workoutRepositoryProvider).saveSession(finalSession);
    _ref.invalidate(workoutSessionsProvider);
    _ref.invalidate(consistencyProvider);
    WakelockPlus.disable();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }
}

final workoutRunnerProvider = StateNotifierProvider.autoDispose
    .family<WorkoutRunnerNotifier, WorkoutRunnerState, WorkoutDay>((ref, day) {
  final userId = ref.watch(authStateProvider).valueOrNull?.id ?? 'local';
  return WorkoutRunnerNotifier(ref, day, userId);
});
