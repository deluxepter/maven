import 'dart:ui';

import 'package:Maven/theme/padding_theme.dart';
import 'package:Maven/theme/text_style_theme.dart';
import 'package:Maven/theme/widget/active_exercise_set_theme.dart';
import 'package:Maven/theme/widget/m_bottom_navigation_bar_theme.dart';
import 'package:Maven/theme/widget/m_dialog_theme.dart';
import 'package:Maven/theme/widget/m_flat_button_theme.dart';
import 'package:Maven/theme/widget/m_icon_theme.dart';
import 'package:Maven/theme/widget/m_popup_menu_theme.dart';
import 'package:Maven/theme/widget/m_text_field_theme.dart';
import 'package:Maven/theme/widget/template_card_theme.dart';
import 'package:Maven/theme/widget/template_folder_theme.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import 'color_theme.dart';

class MavenThemeOptions implements AppThemeOptions  {
  MavenThemeOptions({
    required Color primary,
    required Color secondary,
    required Color background,
    required Color text,
    required Color subtext,
    required Color neutral,
    required Color success,
    required Color error,

    required this.bottomNavigationBar,
    required this.icon,
    required this.popupMenu,
    required this.dialog,
    required this.textField,
    required this.flatButton,

    required this.templateFolder,
    required this.templateCard,
    required this.activeExerciseSet,

    required this.sliverNavigationBarBackgroundColor,
    required this.handleBarColor,
  }) {
    color = ColorTheme(
      primary: primary,
      secondary: secondary,
      background:
      background,
      text: text,
      subtext: subtext,
      neutral: neutral,
      success: success,
      error: error,
    );
    textStyle = TextStyleTheme(
      heading1: text,
      heading2: text,
      body1: text,
      body2: primary,
      subtitle1: subtext,
      subtitle2: primary,
    );
    padding = const PaddingTheme(
      page: 20,
    );
  }

  late final ColorTheme color;
  late final TextStyleTheme textStyle;
  late final PaddingTheme padding;

  final MBottomNavigationBarTheme bottomNavigationBar;
  final MIconTheme icon;
  final MDialogTheme dialog;
  final MPopupMenuTheme popupMenu;
  final MTextFieldTheme textField;
  final MFlatButtonTheme flatButton;

  final TemplateFolderTheme templateFolder;
  final TemplateCardTheme templateCard;
  final ActiveExerciseSetTheme activeExerciseSet;

  final Color sliverNavigationBarBackgroundColor;
  final Color handleBarColor;
}

