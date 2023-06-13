import 'package:flutter/material.dart';
import 'package:maven/common/extension.dart';
import 'package:video_player/video_player.dart';

import '../../../database/database.dart';
import '../../../theme/theme.dart';

class ExerciseDetailWidget extends StatefulWidget {
  const ExerciseDetailWidget({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  State<ExerciseDetailWidget> createState() => _ExerciseDetailWidgetState();
}

class _ExerciseDetailWidgetState extends State<ExerciseDetailWidget> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.exercise.videoPath)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {
          _controller.setLooping(true);
          _controller.play();
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: T(context).padding.page,
            right: T(context).padding.page,
            left: T(context).padding.page,
            bottom: T(context).padding.page / 2,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: T(context).color.secondary,
                  style: BorderStyle.solid
              ),
              borderRadius: BorderRadiusDirectional.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadiusDirectional.circular(12),
              child: _controller.value.isInitialized ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ) : Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()
              ),
            ),
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.health_and_safety,
              ),
            ],
          ),
          title: Text(
            'Muscle',
            style: T(context).textStyle.body1,
          ),
          subtitle: Text(
            widget.exercise.muscleGroup.name.capitalize(),
            style: T(context).textStyle.subtitle1,
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.monitor_heart,
              ),
            ],
          ),
          title: Text(
            'Musculus',
            style: T(context).textStyle.body1,
          ),
          subtitle: Text(
            widget.exercise.muscle.name.parseMuscleToString(),
            style: T(context).textStyle.subtitle1,
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer,),
            ],
          ),
          title: Text(
            'Timer',
            style: T(context).textStyle.body1,
          ),
          subtitle: Text(
            'None',
            style: T(context).textStyle.subtitle1,
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.category,
              ),
            ],
          ),
          title: Text(
            'Equipment',
            style: T(context).textStyle.body1,
          ),
          subtitle: Text(
            widget.exercise.equipment.name.capitalize(),
            style: T(context).textStyle.subtitle1,
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.tune,
              ),
            ],
          ),
          title: Text(
            'Type',
            style: T(context).textStyle.body1,
          ),
          subtitle: Text(
            widget.exercise.exerciseType.name,
            style: T(context).textStyle.subtitle1,
          ),
        ),
      ],
    );
  }
}