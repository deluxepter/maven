import 'package:floor/floor.dart';
import 'package:maven/database/database.dart';

import '../../common/model/timed.dart';

@Entity(
  tableName: 'template_exercise_group',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['id'],
      entity: Bar,
    ),
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['id'],
      entity: Exercise,
    ),
    ForeignKey(
      childColumns: ['template_id'],
      parentColumns: ['id'],
      entity: Template,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class TemplateExerciseGroup extends ExerciseGroup {
  const TemplateExerciseGroup({
    super.id,
    required super.timer,
    required super.weightUnit,
    required super.distanceUnit,
    required super.barId,
    required super.exerciseId,
    super.notes = const [],
  required this.templateId,
    this.exercise = const Exercise.empty(),
    this.exerciseSets = const [],
  });

  @ColumnInfo(name: 'template_id')
  final int templateId;

  @ignore
  final Exercise exercise;

  @ignore
  final List<TemplateExerciseSet> exerciseSets;

  @override
  TemplateExerciseGroup copyWith({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    int? barId,
    int? exerciseId,
    List<Note>? notes,
    int? templateId,
    Exercise? exercise,
    List<TemplateExerciseSet>? exerciseSets,
  }) {
    return TemplateExerciseGroup(
      id: id ?? this.id,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      barId: barId ?? this.barId,
      exerciseId: exerciseId ?? this.exerciseId,
      notes: notes ?? this.notes,
      templateId: templateId ?? this.templateId,
      exercise: exercise ?? this.exercise,
      exerciseSets: exerciseSets ?? this.exerciseSets,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        templateId,
        exercise,
        exerciseSets,
      ];
}
