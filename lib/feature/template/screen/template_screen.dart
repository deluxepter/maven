import 'dart:math';

import 'package:Maven/common/widget/heading.dart';
import 'package:Maven/feature/template/widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widget/m_button.dart';
import '../../../common/widget/titled_scaffold.dart';
import '../../../database/model/workout.dart';
import '../../../theme/theme.dart';
import '../../program/screen/program_builder_screen.dart';
import '../../program/widget/program_list_widget.dart';
import '../../workout/bloc/workout/workout_bloc.dart';
import '../../workout/widget/paused_workout_widget.dart';
import '../bloc/template/template_bloc.dart';
import '../widget/template_list_widget.dart';
import 'edit_template_screen.dart';

/// Screen which manages templates, workouts, and programs
class TemplateScreen extends StatefulWidget {
  /// Creates a screen for managing templates, workouts, and programs
  const TemplateScreen({Key? key}) : super(key: key);

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {


  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Workout',
      body: Padding(
        padding: EdgeInsets.all(T.current.padding.page),
        child: CustomScrollView(
          slivers: [
            const Heading(title: 'Quick Start', topPadding: false,),
            SliverList(delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MButton(
                    onPressed: () {
                      /*context.read<WorkoutBloc>().add(const WorkoutStart());*/
                    },
                    expand: false,
                    width: double.infinity,
                    backgroundColor: T.current.color.primary,
                    child: Text(
                      'Start an Empty Workout',
                      style: T.current.textStyle.button1,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      MButton(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>
                              EditTemplateScreen(
                                onSubmit: (template, exerciseBundles) {
                                  context.read<TemplateBloc>().add(
                                    TemplateCreate(
                                      template: template,
                                      exerciseBundles: exerciseBundles,
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                              )));
                        },
                        borderColor: T.current.color.secondary,
                        leading: const Icon(
                          Icons.post_add,
                        ),
                        child: Text(
                          'Create Template',
                          style: T.current.textStyle.button2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      MButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => const ProgramBuilderScreen()));
                        },
                        borderColor: T.current.color.secondary,
                        leading: const Icon(
                          Icons.polyline,
                        ),
                        child: Text(
                          'Program Builder',
                          style: T.current.textStyle.button2,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ]),),
            const Heading(title: 'In Progress',),
            BlocBuilder<WorkoutBloc, WorkoutState>(
              builder: (context, state) {
                if (state.status == WorkoutStatus.loading) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                } else if (state.status == WorkoutStatus.error) {
                  return SliverToBoxAdapter(
                    child: Text(
                      'Something s wrong',
                      style: T.current.textStyle.body1,
                    ),
                  );
                } else {
                  List<Workout> workouts = state.pausedWorkouts;

                  return workouts.isEmpty ? const EmptyWidget() :
                  SliverList(

                    /// [SliverList] with [SizedBox] dividers between [PausedWorkoutWidget]s
                    ///
                    /// Mimics a [ListView.separated] since there's no SliverList.separated
                    ///
                    /// [Source](https://stackoverflow.com/a/58176779)
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        final int itemIndex = index ~/ 2;
                        if (index.isEven) {
                          return PausedWorkoutWidget(
                              workout: workouts[itemIndex]);
                        }
                        return const SizedBox(height: 15);
                      },
                      semanticIndexCallback: (Widget widget, int localIndex) {
                        if (localIndex.isEven) {
                          return localIndex ~/ 2;
                        }
                        return null;
                      },
                      childCount: max(0, workouts.length * 2 - 1),
                    ),
                  );
                }
              },
            ),
            const Heading(title: 'Templates',),
            const TemplateListWidget(),
            const Heading(title: 'Programs',),
            const ProgramListWidget(),
            const SliverToBoxAdapter(
             child: SizedBox(
               height: 150,
             ),
            ),
          ],
        ),
      ),
    );
  }
}