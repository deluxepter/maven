import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/util/general_utils.dart';
import '../../../theme/theme.dart';
import '../model/complete_bundle.dart';
import '../model/complete_exercise_bundle.dart';
import '../screen/complete_detail_screen.dart';

class CompleteWidget extends StatelessWidget {
  const CompleteWidget({Key? key,
    required this.completeBundle,
  }) : super(key: key);

  final CompleteBundle completeBundle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: T.current.color.background,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteDetailScreen(
            completeBundle: completeBundle,
          )));
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: T.current.color.secondary,
            ),
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                completeBundle.complete.name,
                style: T.current.textStyle.heading3,
              ),
              SizedBox(height: 5,),
              Text(
                DateFormat.yMMMMEEEEd().format(completeBundle.complete.timestamp).toString(),
                style: T.current.textStyle.subtitle2,
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: T.current.color.subtext,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    durationToTime(completeBundle.complete.duration),
                    style: T.current.textStyle.body1,
                  ),
                  SizedBox(width: 20,),
                  Icon(
                    Icons.monitor_weight,
                    color: T.current.color.subtext,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    completeBundle.volume.toString(),
                    style: T.current.textStyle.body1,
                  ),
                  SizedBox(width: 20,),

                ],
              ),
              SizedBox(height: 12,),
              completeBundle.completeExerciseBundles.isNotEmpty ? ListView.builder(
                itemCount: completeBundle.completeExerciseBundles.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  CompleteExerciseBundle completeExerciseBundle = completeBundle.completeExerciseBundles[index];
                  return Text(
                    '${completeExerciseBundle.completeExerciseSets.length} x ${completeExerciseBundle.exercise.name}',
                    style: T.current.textStyle.subtitle1,
                  );
                },
              ) : Text(
                'None',
                style: T.current.textStyle.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
