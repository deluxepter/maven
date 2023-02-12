import 'package:Maven/feature/workout/m_keyboard/widget/barbell_calculator_widget.dart';
import 'package:flutter/material.dart';

import '../../../../theme/m_themes.dart';
import '../../../../widget/m_flat_button.dart';
import 'numpad_widget.dart';

enum MKeyboardType {
  regular,
  barbell,
  distance,
  time,
}

class MKeyboard extends StatefulWidget {
  MKeyboard({Key? key,
    required this.mKeyboardType,
    required this.value,
    required this.onValueChanged,
  }) : super(key: key);

  final MKeyboardType mKeyboardType;

  String value;

  final Function(String) onValueChanged;

  @override
  State<MKeyboard> createState() => _MKeyboardState();
}

class _MKeyboardState extends State<MKeyboard> {

  int _selectedTab = 2;

  @override
  void initState() {

    super.initState();
  }

  Widget _buildScreen(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return Container();
      case 1:
        return BarbellCalculatorWidget(
          weight: widget.value.isEmpty ? 0 : int.parse(widget.value).toDouble(),
        );
      default:
        return NumPadWidget(
          value: widget.value,
          onValueChanged: (value) {
            setState(() {
              widget.value = value;
              widget.onValueChanged(value);
            });
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        Expanded(
          child: Container(height: double.infinity, child: _buildScreen(_selectedTab)),
        ),

        Container(
          width: 1,
          color: mt(context).borderColor,
        ),

        Container(
          width: 70,
          child: Column(
            children: [
              MFlatButton(
                onPressed: (){
                  setState(() {
                    _selectedTab = 0;
                  });
                },
                borderRadius: 0,
                icon: Icon(
                  Icons.history_rounded,
                  color: _selectedTab == 0 ? mt(context).icon.accentColor : mt(context).icon.primaryColor,
                ),
              ),
              MFlatButton(
                onPressed: (){
                  setState(() {
                    _selectedTab = 1;
                  });
                },
                borderRadius: 0,
                icon: Icon(
                  Icons.calculate_rounded,
                  color: _selectedTab == 1 ? mt(context).icon.accentColor : mt(context).icon.primaryColor,
                ),
              ),
              MFlatButton(
                onPressed: (){
                  setState(() {
                    _selectedTab = 2;
                  });
                },
                borderRadius: 0,
                icon: Icon(
                  Icons.numbers_rounded,
                  color: _selectedTab == 2 ? mt(context).icon.accentColor : mt(context).icon.primaryColor,
                ),
              ),
              MFlatButton(
                onPressed: (){
                  //widget.onValueChanged(_controller.text);
                  Navigator.pop(context);
                },
                borderRadius: 0,
                icon: const Icon(
                    Icons.check
                ),
              ),
            ],
          ),
        )

      ],
    );
  }


}