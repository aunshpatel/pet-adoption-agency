import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(ThemeData initialTheme) : super(ThemeState(themeData: initialTheme)) {
    on<ToggleTheme>((event, emit) async {
      final newTheme = state.themeData.brightness == Brightness.dark ? ThemeData.light() : ThemeData.dark();
      emit(ThemeState(themeData: newTheme));
      await _saveTheme(newTheme.brightness == Brightness.dark);
    });
  }

  Future<void> _saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}
