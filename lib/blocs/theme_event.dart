import 'package:flutter/material.dart';

abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class SetTheme extends ThemeEvent {
  final ThemeData themeData;
  SetTheme(this.themeData);
}
