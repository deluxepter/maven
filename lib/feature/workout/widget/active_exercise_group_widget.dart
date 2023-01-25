import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/common/model/exercise.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/bloc/active_workout/workout_bloc.dart';
import 'package:Maven/feature/workout/widget/active_exercise_set_widget.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/m_flat_button.dart';
import 'package:Maven/widget/m_popup_menu_button.dart';
import 'package:Maven/widget/m_popup_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveExerciseGroupWidget extends StatefulWidget {
  final ActiveExerciseGroup activeExerciseGroup;
  final List<ActiveExerciseSet> activeExerciseSets;

  const ActiveExerciseGroupWidget({Key? key,
    required this.activeExerciseGroup,
    required this.activeExerciseSets
  }) : super(key: key);


  @override
  State<ActiveExerciseGroupWidget> createState() => _ActiveExerciseGroupWidgetState();
}

class _ActiveExerciseGroupWidgetState extends State<ActiveExerciseGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FutureBuilder(
          future: DBHelper.instance.getExercise(widget.activeExerciseGroup.exerciseId),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return const Text("cant get exercises");
            Exercise exercise = snapshot.data!;
            return Row(
              children: [

                const SizedBox(width: 10),

                Expanded(
                  child: TextButton(
                    onPressed: () {  },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        exercise.name,
                        style: TextStyle(
                          fontSize: 18,
                          color: mt(context).text.accentColor,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 52,
                  width: 52,
                  child: MPopupMenuButton(
                    iconColor: mt(context).icon.accentColor,
                    color: mt(context).popupMenu.backgroundColor,
                    children: [
                      MPopupMenuItem.build(
                        icon: Icon(
                          Icons.straighten,
                          size: 21,
                          color: mt(context).text.accentColor,
                        ),
                        text: 'Weight Unit',
                        textColor: mt(context).text.primaryColor,
                        onTap: (){}
                      ),
                      MPopupMenuItem.build(
                          icon: Icon(
                            Icons.timer_outlined,
                            size: 21,
                            color: mt(context).text.accentColor,
                          ),
                          text: 'Auto Rest Timer',
                          textColor: mt(context).text.primaryColor,
                          onTap: (){}
                      ),
                      MPopupMenuItem.build(
                        icon: Icon(
                          Icons.delete,
                          size: 21,
                          color: mt(context).icon.errorColor,
                        ),
                        text: 'Remove Exercise',
                        textColor: mt(context).text.errorColor,
                        onTap: (){}
                      ),
                    ]
                  )
                )

              ],
            );
          },
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:  [
            const SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.center,
              width: 35,
              child: Text(
                "SET",
                style: TextStyle(
                  fontSize: 13,
                  color: mt(context).text.primaryColor
                ),
              )
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.center,
              width: 90,
              child: Text(
                "PREVIOUS",
                style: TextStyle(
                  fontSize: 13,
                  color: mt(context).text.primaryColor
                ),
              )
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "WEIGHT",
                  style: TextStyle(
                    fontSize: 13,
                    color: mt(context).text.primaryColor,
                  ),
                )
              )
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "REPS",
                  style: TextStyle(
                    fontSize: 13,
                    color: mt(context).text.primaryColor,
                  ),
                )
              )
            ),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
              width: 46,
              child: Text(""),
            ),
          ],
        ),

        ListView.builder(
          itemCount: widget.activeExerciseSets.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {

            ActiveExerciseSet activeExerciseSet = widget.activeExerciseSets[index];

            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                context.read<WorkoutBloc>().add(DeleteActiveExerciseSet(
                    activeExerciseSetId: widget.activeExerciseSets[index].activeExerciseSetId!
                ));
              },
              background: Container(
                color: Colors.redAccent,
              ),
              child: ActiveExerciseSetWidget(
                index: index + 1,
                activeExerciseSet: activeExerciseSet
              ),
            );
          },
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
          child: MFlatButton(
            onPressed: (){
              context.read<WorkoutBloc>().add(AddActiveExerciseSet(
                activeExerciseGroupId: widget.activeExerciseGroup.activeExerciseGroupId!
              ));
            },
            expand: false,
            icon: Icon(
              Icons.add_rounded,
              size: 24,
              color: mt(context).icon.accentColor,
            ),
            text: Text(
              'Add Set',
              style: TextStyle(
                color: mt(context).text.accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
