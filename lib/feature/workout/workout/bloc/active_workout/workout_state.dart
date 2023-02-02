part of 'workout_bloc.dart';

enum WorkoutStatus {
  initial,
  loading,
  success,
  none,
  active
}

class WorkoutState extends Equatable {
  const WorkoutState({
    this.status = WorkoutStatus.initial,
    this.workout,
    this.pausedWorkouts = const [],
    this.activeExerciseGroups = const [],
    this.activeExerciseSets = const [],
    this.exercises = const [],
  });

  final WorkoutStatus status;
  final Workout? workout;
  final List<Workout> pausedWorkouts;
  final List<WorkoutExerciseGroup> activeExerciseGroups;
  final List<WorkoutExerciseSet> activeExerciseSets;
  final List<Exercise> exercises;


  WorkoutState copyWith({
    WorkoutStatus Function()? status,
    Workout Function()? workout,
    List<Workout> Function()? pausedWorkouts,
    List<WorkoutExerciseGroup> Function()? activeExerciseGroups,
    List<WorkoutExerciseSet> Function()? activeExerciseSets,
    List<Exercise> Function()? exercises,
  }) {
    return WorkoutState(
      status: status != null ? status() : this.status,
      workout: workout != null ? workout() : this.workout,
      pausedWorkouts: pausedWorkouts != null ? pausedWorkouts() : this.pausedWorkouts,
      activeExerciseGroups: activeExerciseGroups != null ? activeExerciseGroups() : this.activeExerciseGroups,
      activeExerciseSets: activeExerciseSets != null ? activeExerciseSets() : this.activeExerciseSets,
      exercises: exercises != null ? exercises() : this.exercises,
    );
  }

  @override
  List<Object?> get props => [
    status,
    workout,
    pausedWorkouts,
    activeExerciseGroups,
    activeExerciseSets,
    exercises,
  ];
}