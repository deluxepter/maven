import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

class TextStyleScreen extends StatelessWidget {
  const TextStyleScreen({Key? key}) : super(key: key);

  ListTile textStyle(String title, TextStyle textStyle) => ListTile(
    onTap: (){

    },
    title: Text(
      title,
      style: textStyle,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text Style',
        ),
      ),
      body: ListView(
        children: [
          textStyle('Heading 1', mt(context).textStyle.heading1),
          textStyle('Heading 2', mt(context).textStyle.heading2),
          textStyle('Heading 3', mt(context).textStyle.heading3),
          textStyle('Body 1', mt(context).textStyle.body1),
          textStyle('Subtitle 1', mt(context).textStyle.subtitle1),
          textStyle('Subtitle 2', mt(context).textStyle.subtitle2),
          textStyle('Button 1', mt(context).textStyle.button1),
          textStyle('Button 2', mt(context).textStyle.button2),
        ],
      ),
    );
  }
}