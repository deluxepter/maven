import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/common.dart';
import 'package:maven/feature/exercise/exercise.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../settings/settings.dart';
import '../../theme/theme.dart';
import '../../home/home.dart';
import '../../profile/screen/profile_screen.dart';
import '../../progress/screen/progress_screen.dart';
import '../../template/template.dart';
import '../../workout/workout.dart';


class Maven extends StatefulWidget {
  const Maven({super.key});

  @override
  State<Maven> createState() => _MavenState();
}

class _MavenState extends State<Maven> {
  final List<Widget> screens = <Widget>[
    const HomeScreen(),
    const TemplateScreen(),
    const ProgressScreen(),
    const ProfileScreen(),
  ];

  int _selectedIndex = 1;

  final ExerciseTimerController timerController = ExerciseTimerController();
  final PanelController _panelController = PanelController();

  double panelPosition = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: T(context).color.background,
      body: SafeArea(child: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state.status.isLoading || state.status.isNone) {
            return screens[_selectedIndex];
          } else if (state.status.isActive) {
            return SlidingUpPanel(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              minHeight: 80,
              onPanelSlide: (position) {
                setState(() {
                  panelPosition = position;
                });
              },
              maxHeight: MediaQuery.of(context).size.height,
              backdropEnabled: true,
              controller: _panelController,
              color: T(context).color.background,
              boxShadow: [
                BoxShadow(
                  color: T(context).color.shadow,
                  blurRadius: 3,
                ),
              ],
              body: screens[_selectedIndex],
              collapsed: IgnorePointer(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(T(context).shape.large),
                      topRight: Radius.circular(T(context).shape.large),
                    ),
                    color: T(context).color.surface.balance(InheritedThemeWidget.of(context).theme.brightness),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 7),
                      Container(
                        height: 6,
                        width: 48,
                        decoration: BoxDecoration(
                          color: T(context).color.outline,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.workout!.routine.name,
                        style: T(context).textStyle.titleLarge,
                      ),
                      const SizedBox(height: 1),
                      StreamBuilder(
                        stream: Stream.periodic(
                          const Duration(
                            seconds: 1,
                          ),
                        ),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          return Text(
                            'hey',
                            //workoutDuration(state.workout?.timestamp ?? DateTime.now()),
                            style: T(context).textStyle.bodyMedium,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              panel: Container(
                height: 85,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: T(context).color.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 7),
                    Container(
                      height: 6,
                      width: 48,
                      decoration: BoxDecoration(
                        color: T(context).color.outline,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    WorkoutScreen(
                      workout: state.workout!,
                      timerController: timerController,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text(
              'Naughty Error',
              style: T(context).textStyle.bodyLarge,
            );
          }
        },
      )),
      bottomNavigationBar: SizedBox(
        height: (1 - panelPosition) * 80,
        child: NavigationBar(
          onDestinationSelected: _onItemTapped,
          selectedIndex: _selectedIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.fitness_center),
              label: 'Workout',
            ),
            NavigationDestination(
              icon: Icon(Icons.stacked_line_chart),
              label: 'Progress',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
