
import 'package:collection/collection.dart';
import 'package:csv/csv.dart';

import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../../session/session.dart';
import '../transfer.dart';

enum TransferType {
  strong,
  hevy,
}

class TransferService {
  const TransferService({
    required this.exercises,
  });

  final List<Exercise> exercises;

  List<Session> parse(String csv, TransferType type) {
    List<List<dynamic>> data = const CsvToListConverter(eol: '\n').convert(csv);

    List<CSVRow> rows = [];

    switch (type) {
      case TransferType.strong:
        for(int i = 1; i < data.length; i++) {
          rows.add(StrongRow(data[i]));
        }
        break;
      case TransferType.hevy:
        rows = data.map((e) => HevyRow(e)).toList();
    }

    List<Session> sessions = [];

    for (int i = 1; i < rows.length; i++) {
      CSVRow row = rows[i];

      int sessionIndex = sessions.indexWhere((element) {
        return element.routine.timestamp == DateTimeConverter().decode(row.date);
      });

      print(sessionIndex);

      if (sessionIndex == -1) {
        sessions.add(Session(
          routine: Routine(
            timestamp: DateTimeConverter().decode(row.date),
            name: row.workoutName,
            type: RoutineType.session,
            note: 'BLANK',
          ),
          data: SessionData(
            routineId: -1,
            timeElapsed: TimedConverter().decode(int.parse(row.workoutDuration)),
          ),
          exerciseGroups: [],
        ));

        sessionIndex = sessions.length - 1;
      }

      Exercise? temp = exercises.firstWhereOrNull((element) {
        return element.conversions.where((element) {
          return element.name == row.exerciseName;
        }).toList().isNotEmpty;
      });

      if(temp == null) continue;


      int groupIndex = sessions[sessionIndex].exerciseGroups.indexWhere((element) {
        return element.exerciseId == temp.id;
      });

      if(groupIndex == -1) {
        sessions[sessionIndex].exerciseGroups.add(ExerciseGroup(
          exerciseId: temp.id!,
          distanceUnit: temp.distanceUnit,
          weightUnit: temp.weightUnit,
          timer: temp.timer,
          barId: temp.barId,
          routineId: -1,
          sets: [],
        ));

        groupIndex = sessions[sessionIndex].exerciseGroups.length - 1;
      }

      List<ExerciseSetData> data = [];

      if(row.weight != '0') {
        data.add(ExerciseSetData(
          fieldType: ExerciseFieldType.weight,
          value: row.weight,
          exerciseSetId: -1,
        ));
      }

      if(row.reps != '0') {
        data.add(ExerciseSetData(
          fieldType: ExerciseFieldType.reps,
          value: row.reps,
          exerciseSetId: -1,
        ));
      }

      if(row.distance != '0') {
        data.add(ExerciseSetData(
          fieldType: ExerciseFieldType.distance,
          value: row.distance,
          exerciseSetId: -1,
        ));
      }

      if(row.duration != '0') {
        data.add(ExerciseSetData(
          fieldType: ExerciseFieldType.duration,
          value: row.duration,
          exerciseSetId: -1,
        ));
      }

      sessions[sessionIndex].exerciseGroups[groupIndex].sets.add(ExerciseSet(
        type: ExerciseSetType.regular,
        exerciseGroupId: -1,
        checked: true,
        data: data,
      ));
    }
    return sessions;
  }
}