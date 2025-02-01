import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: ThemeData.light())) {
    on<ToggleTheme>((event, emit) {
      final newTheme = state.themeData.brightness == Brightness.dark ? ThemeData.light() : ThemeData.dark();
      emit(ThemeState(themeData: newTheme));
    });
  }
}