import 'package:Maven/feature/exercise/model/exercise_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/model/timed.dart';
import '../../../database/model/model.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../../exercise/model/exercise_bundle.dart';
import '../../exercise/model/exercise_set.dart';
import '../../exercise/model/set_type.dart';
import '../../exercise/screen/exercise_selection_screen.dart';
import '../../exercise/widget/exercise_group_widget.dart';

typedef TemplateEditCallback = void Function(Template template, List<ExerciseBundle> bundles);

/// Screen for creating and editing a [Template]
class EditTemplateScreen extends StatefulWidget {
  /// Creates a screen for creating and editing a [Template]
  const EditTemplateScreen({Key? key,
    this.template,
    this.exerciseBundles,
    required this.onSubmit,
  }) : super(key: key);

  final Template? template;
  final List<ExerciseBundle>? exerciseBundles;
  final TemplateEditCallback onSubmit;

  @override
  State<EditTemplateScreen> createState() => _EditTemplateScreenState();
}

class _EditTemplateScreenState extends State<EditTemplateScreen> {
  late Template template;
  late List<ExerciseBundle> exerciseBundles;

  bool _isReorder = false;

  @override
  void initState() {
    if(widget.exerciseBundles == null) {
      exerciseBundles = [];
    } else {
      exerciseBundles = widget.exerciseBundles!.map((e) => e.copyWith()).toList();
    }
    if(widget.template == null) {
      template = const Template(
        name: 'Untitled',
        description: 'Enter a description',
      );
    } else {
      template = widget.template!.copyWith();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.exerciseBundles == null ? 'Create' : 'Edit',
        ),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                _isReorder = !_isReorder;
              });
            },
            icon: Icon(
              _isReorder ? Icons.format_list_bulleted : CupertinoIcons.arrow_up_arrow_down,
              size: _isReorder ? 24 : 20,
            ),
          ),
          IconButton(
            onPressed: (){
              if(template.name.isEmpty || template.description.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Please fill in all fields',
                    ),
                  ),
                );
                return;
              }
              widget.onSubmit(template, exerciseBundles);
            },
            icon: const Icon(
              Icons.check_rounded,
            ),
          ),
        ],
      ),
      body: _isReorder ?
      ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final ExerciseBundle item = exerciseBundles.removeAt(oldIndex);
            exerciseBundles.insert(newIndex, item);
          });
        },
        proxyDecorator: (widget, index, animation) {
          return Material(
            child: widget,
            color: Colors.transparent,
          );
        },
        children: exerciseBundles.map((e) => ReorderableDragStartListener(
          key: UniqueKey(),
          index: exerciseBundles.indexOf(e),
            child: ListTile(
              title: Text(e.exercise.name),
              leading: Icon(Icons.drag_indicator_rounded),
            ),
          ),
        ).toList(),
      )
          :
      CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              left: T(context).padding.page,
              right: T(context).padding.page,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                TextFormField(
                  onChanged: (value) {
                    template = template.copyWith(name: value);
                  },
                  initialValue: template.name,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Workout',
                  ),
                  style: T(context).textStyle.heading1,
                ),
                TextFormField(
                  onChanged: (value) {
                    template = template.copyWith(description: value);
                  },
                  initialValue: template.description,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: -25, bottom: 0, left: 0, right: 0),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Description',
                  ),
                  style: T(context).textStyle.subtitle1,
                ),
              ]),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: exerciseBundles.length,
              (context, index) {
                ExerciseBundle exerciseBlock = exerciseBundles[index];
                return ExerciseGroupWidget(
                  key: UniqueKey(),
                  exercise: exerciseBlock.exercise,
                  exerciseGroup: exerciseBlock.exerciseGroup,
                  exerciseSets: exerciseBlock.exerciseSets,
                  onExerciseGroupUpdate: (value) {
                    setState(() {
                      exerciseBundles[index].exerciseGroup = value;
                    });
                  },
                  onExerciseGroupDelete: () {
                    setState(() {
                      exerciseBundles.removeAt(index);
                    });
                  },
                  onExerciseSetAdd: (value) {
                    setState(() {
                      exerciseBundles[index].exerciseSets.add(value);
                    });
                  },
                  onExerciseSetUpdate: (value) {
                    setState(() {
                      int exerciseSetIndex = exerciseBundles[index].exerciseSets.indexWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
                      exerciseBundles[index].exerciseSets[exerciseSetIndex] = value;
                    });
                  },
                  onExerciseSetDelete: (value) {
                    setState(() {
                      exerciseBundles[index].exerciseSets.removeWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
                    });
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onPressed: () async {
            List<Exercise>? exercises = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ExerciseSelectionScreen()));

            for (Exercise exercise in exercises ?? []) {
              setState(() {
                int exerciseGroupId = DateTime.now().millisecondsSinceEpoch;
                exerciseBundles.add(ExerciseBundle(
                  exercise: exercise,
                  exerciseGroup: ExerciseGroup(
                    exerciseGroupId: exerciseGroupId,
                    restTimed: Timed.zero(),
                    exerciseId: exercise.exerciseId!,
                    barId: exercise.barId,
                  ),
                  exerciseSets: [
                    ExerciseSet(
                      exerciseSetId: DateTime.now().millisecondsSinceEpoch,
                      option1: 0,
                      option2: 0,
                      exerciseGroupId: exerciseGroupId,
                      setType: SetType.regular,
                    )
                  ],
                  barId: exercise.barId,
                ));
              });
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
