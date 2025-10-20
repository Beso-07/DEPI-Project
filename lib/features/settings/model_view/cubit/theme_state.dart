part of 'theme_cubit.dart';

sealed class ThemeState  {
  const ThemeState();

  
}

class ThemeInitial extends ThemeState {}

class ThemeChanged extends ThemeState {
  final ThemeData themeData;
  const ThemeChanged(this.themeData);
}