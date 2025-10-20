import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial()) {
    _loadSettings();
  }

  final List<String> availableCountries = [
    'مصر',
    'السعودية',
    'الإمارات',
    'الكويت',
    'قطر',
    'البحرين',
  ];

  final List<String> availableLanguages = [
    'عربية',
    'English',
    'Français',
  ];

  void _loadSettings() {
    emit(SettingsLoaded(
      isDaylightSavingEnabled: true,
      isDarkModeEnabled: false,
      selectedCountry: 'تلقائي',
      selectedLanguage: 'عربية',
    ));
  }

  void toggleDaylightSaving(bool value) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(currentState.copyWith(isDaylightSavingEnabled: value));
      _saveSettings();
    }
  }

  void toggleThemeSaving(bool value) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(currentState.copyWith(isDarkModeEnabled: value));
      _saveSettings();
    }
  }

  void changeCountry(String country) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(currentState.copyWith(selectedCountry: country));
      _saveSettings();
    }
  }

  void changeLanguage(String language) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(currentState.copyWith(selectedLanguage: language));
      _saveSettings();
    }
  }

  void _saveSettings() {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;

      print('Saving settings:');
      print('Daylight Saving: ${currentState.isDaylightSavingEnabled}');
      print('Dark Mode: ${currentState.isDarkModeEnabled}');
      print('Country: ${currentState.selectedCountry}');
      print('Language: ${currentState.selectedLanguage}');
    }
  }

  void resetSettings() {
    emit(SettingsLoaded(
      isDaylightSavingEnabled: true,
      isDarkModeEnabled: false,
      selectedCountry: 'مصر',
      selectedLanguage: 'عربية',
    ));
    _saveSettings();
  }
}
