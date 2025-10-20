abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool isDaylightSavingEnabled;
  final bool isDarkModeEnabled;
  final String selectedCountry;
  final String selectedLanguage;

  SettingsLoaded({
    required this.isDaylightSavingEnabled,
    required this.isDarkModeEnabled,
    required this.selectedCountry,
    required this.selectedLanguage,
  });

  SettingsLoaded copyWith({
    bool? isDaylightSavingEnabled,
    bool? isDarkModeEnabled,  
    String? selectedCountry,
    String? selectedLanguage,
  }) {
    return SettingsLoaded(
      isDaylightSavingEnabled: isDaylightSavingEnabled ?? this.isDaylightSavingEnabled,
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}

class SettingsError extends SettingsState {
  final String message;
  
  SettingsError(this.message);
}