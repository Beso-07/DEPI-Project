part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  final ThemeData themeData;
  const ThemeState(this.themeData);

  @override
  List<Object?> get props => [themeData];
}

class ThemeInitial extends ThemeState {
  ThemeInitial()
      : super(
          ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
            textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
          ),
        );
}

class LightThemeState extends ThemeState {
  const LightThemeState({required ThemeData themeData}) : super(themeData);
}

class DarkThemeState extends ThemeState {
  const DarkThemeState({required ThemeData themeData}) : super(themeData);
}
