import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
  );

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
  );

  void toggleTheme() {
    if (state is LightThemeState) {
      emit(DarkThemeState(themeData: _darkTheme));
    } else {
      emit(LightThemeState(themeData: _lightTheme));
    }
  }
}
