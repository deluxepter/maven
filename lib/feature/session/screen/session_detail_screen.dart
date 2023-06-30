import 'package:flutter/material.dart';

import '../../../database/model/model.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../model/complete_bundle.dart';
import '../model/complete_exercise_bundle.dart';

class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({
    Key? key,
    required this.completeBundle,
  }) : super(key: key);

  final SessionBundle completeBundle;

  List<TextSpan> test(SessionExerciseBundle seb, int index, BuildContext context) {
    List<TextSpan> result = [];

    result.add(TextSpan(
      text: '${index + 1}  ',
      style: T(context).textStyle.bodyMedium.copyWith(
            color: seb.sessionExerciseSets[index].type.color(context),
          ),
    ));

    for (int i = 0; i < seb.sessionExerciseSets[index].data.length; i++) {
      result.add(TextSpan(
        text: seb.sessionExerciseSets[index].data[i].stringify(seb.sessionExerciseGroup),
        style: TextStyle(
          color: T(context).color.onBackground,
        ),
      ));

      if (i < seb.sessionExerciseSets[index].data.length - 1) {
        result.add(TextSpan(
          text: ' x ',
          style: TextStyle(
            color: T(context).color.onBackground,
          ),
        ));
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          completeBundle.session.name,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: T(context).space.large,
          right: T(context).space.large,
          top: T(context).space.large,
        ),
        child: ListView.separated(
          itemCount: completeBundle.sessionExerciseBundles.length,
          separatorBuilder: (context, index) => SizedBox(
            height: 12,
          ),
          itemBuilder: (context, index) {
            SessionExerciseBundle completeExerciseBundle = completeBundle.sessionExerciseBundles[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  completeExerciseBundle.exercise.name,
                  style: T(context).textStyle.bodyLarge,
                ),
                const SizedBox(
                  height: 2,
                ),
                ListView.builder(
                  itemCount: completeExerciseBundle.sessionExerciseSets.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    SessionExerciseSet completeExerciseSet = completeExerciseBundle.sessionExerciseSets[index];
                    return RichText(
                      text: TextSpan(
                        style: T(context).textStyle.bodyMedium,
                        children: test(completeExerciseBundle, index, context),
                      ),
                    );
                    /*return Text(
                      ' ${completeExerciseSet.option1} x ${completeExerciseSet.option2}',
                      style: T(context).textStyle.body1,
                    );*/
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}