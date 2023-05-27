import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/setting/bloc/setting_bloc.dart';
import 'app_theme_options.dart';
import 'color_options.dart';
import 'padding_options.dart';
import 'text_style_options.dart';
import 'theme_options.dart';

class AppTheme extends Equatable {
  const AppTheme({
    required this.id,
    required this.name,
    required this.path,
    required this.options,
  });

  final int id;
  final String name;
  final String path;
  final AppThemeOptions options;

  ThemeData get data {
    return ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: options.color.background,
        foregroundColor: options.color.text,
        iconTheme: IconThemeData(
          color: options.color.primary,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: options.color.background,
        selectedItemColor: options.color.primary,
        unselectedItemColor: options.color.subtext,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
      iconTheme: IconThemeData(
        color: options.color.primary,
      ),
      scaffoldBackgroundColor: options.color.background,
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.only(left: 20),
        iconColor: options.color.primary,
        textColor: options.color.text,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return options.color.primary;
          } else {
            return options.color.secondary;
          }
        }),
        checkColor: MaterialStateProperty.all(options.color.background),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: options.color.subtext,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: options.color.secondary,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: options.color.primary,
            width: 2,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: options.color.primary,
        foregroundColor: options.color.background,
      ),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        path,
        options,
      ];

  static const AppTheme dark = AppTheme(
    id: 2,
    name: 'assets/image/light.jpg',
    path: 'N/A',
    options: AppThemeOptions(
      primary: Color(0xFF2196F3),
      secondary: Color(0xFF333333),
      background: Color(0xff121212),
      text: Color(0xffffffff),
      subtext: Color(0xFF808080),
      neutral: Color(0xFFFFFFFF),
      success: Color(0xFF2DCD70),
      error: Color(0xFFDD614A),
      shadow: Color(0xFF353535),
      warmup: Color(0xFFFFAE00),
      drop: Color(0xFFBD4ADD),
      cooldown: Color(0xFF21F3F3),
    ),
  );

  static const List<AppTheme> defaultThemes = [
    AppTheme(
      id: 1,
      name: 'Light',
      path: 'assets/image/light.jpg',
      options: AppThemeOptions(
        primary: Color(0xFF2196F3),
        secondary: Color(0xFFEAEAEA),
        background: Color(0xffffffff),
        text: Color(0xff000000),
        subtext: Color(0xFF808080),
        neutral: Color(0xFFFFFFFF),
        success: Color(0xFF2DCD70),
        error: Color(0xFFDD614A),
        shadow: Color(0xFFC1C1C1),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
    AppTheme(
      id: 2,
      name: 'Dark',
      path: 'assets/image/dark.jpg',
      options: AppThemeOptions(
        primary: Color(0xFF2196F3),
        secondary: Color(0xFF333333),
        background: Color(0xff121212),
        text: Color(0xffffffff),
        subtext: Color(0xFF808080),
        neutral: Color(0xFFFFFFFF),
        success: Color(0xFF2DCD70),
        error: Color(0xFFDD614A),
        shadow: Color(0xFF353535),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
    AppTheme(
      id: 3,
      name: 'Solar flare',
      path: 'assets/image/solar_flare.jpg',
      options: AppThemeOptions(
        primary: Color(0xFFFFAE00),
        secondary: Color(0xFF333333),
        background: Color(0xff232323),
        text: Color(0xffffffff),
        subtext: Color(0xFF808080),
        neutral: Color(0xFFFFFFFF),
        success: Color(0xFF922DCD),
        error: Color(0xFFDD614A),
        shadow: Color(0xFF353535),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
    AppTheme(
      id: 4,
      name: 'Nature',
      path: 'assets/image/nature.jpg',
      options: AppThemeOptions(
        primary: Color(0xFF4CAF50),
        secondary: Color(0xFF8BC34A),
        background: Color(0xFFE8F5E9),
        text: Color(0xFF212121),
        subtext: Color(0xFF757575),
        neutral: Color(0xFFFFFFFF),
        success: Color(0xFF4CAF50),
        error: Color(0xFFDD614A),
        shadow: Color(0xFFBDBDBD),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
    AppTheme(
      id: 5,
      name: 'Rose Gold',
      path: 'assets/image/rose_gold.jpg',
      options: AppThemeOptions(
        primary: Color(0xFFE91E63),
        secondary: Color(0xFFFFDF9F),
        background: Color(0xFFFAF0E6),
        text: Color(0xFF212121),
        subtext: Color(0xFF757575),
        neutral: Color(0xFFFFFFFF),
        success: Color(0xFFAF4C4C),
        error: Color(0xFFDD614A),
        shadow: Color(0xFFBDBDBD),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
    AppTheme(
      id: 6,
      name: 'Custom',
      path: 'assets/image/custom.jpg',
      options: AppThemeOptions(
        primary: Color(0xFF2196F3),
        secondary: Color(0xFFEAEAEA),
        background: Color(0xffffffff),
        text: Color(0xff000000),
        subtext: Color(0xFF808080),
        neutral: Color(0xFFFFFFFF),
        success: Color(0xFF2DCD70),
        error: Color(0xFFDD614A),
        shadow: Color(0xFFC1C1C1),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
  ];
}

/// Convenient singleton to access the current [ThemeOptions] from [SettingBloc] state.
///
/// Example:
/// ```dart
/// T.current.textStyle.headline1
/// ```
class T implements ThemeOptions {
  T(this._context);

  static T? _current;

  final BuildContext _context;

  static T get current {
    assert(_current != null, 'No instance of T was loaded. Try to initialize the T delegate before accessing T.current.');
    return _current!;
  }

  static load(BuildContext context) {
    _current = T(context);
  }

  @override
  TextStyleOptions get textStyle {
    return _context.read<SettingBloc>().state.currentTheme.options.textStyle;
  }

  @override
  ColorOptions get color {
    return _context.read<SettingBloc>().state.currentTheme.options.color;
  }

  @override
  PaddingOptions get padding {
    return _context.read<SettingBloc>().state.currentTheme.options.padding;
  }
}
