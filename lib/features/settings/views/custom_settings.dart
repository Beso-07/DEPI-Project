import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/settings/model_view/cubit/theme_cubit.dart';
import 'package:depiproject/features/settings/model_view/settings_cubit.dart';
import 'package:depiproject/features/settings/model_view/settings_state.dart';
import 'package:depiproject/features/settings/views/widgets/custom_settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSettings extends StatelessWidget {
  const CustomSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(
          create: (context) => ThemeCubit(),
        )
      ],
      child: Scaffold(
        body: Column(
          children: [
            const MainAppBar(title: "الاعدادات العامة"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    if (state is SettingsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is SettingsError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is SettingsLoaded) {
                      return Column(
                        children: [
                          CustomSettingsItem(
                            title: "الحساب الشخصي",
                            onTap: () {},
                          ),
                          CustomSettingsItem(
                            title: "الموقع الجغرافي",
                            optionalText: state.selectedCountry,
                            onTap: () => _showCountryPicker(context),
                          ),
                          CustomSettingsItem(
                            title: "اللغة",
                            optionalText: state.selectedLanguage,
                            onTap: () => _showLanguagePicker(context),
                          ),
                          CustomSettingsItem(
                            title: "الاشعارات",
                            onTap: () {},
                          ),
                          CustomSettingsItem(
                            title: "المحفوظات",
                            onTap: () {},
                          ),
                          CustomSettingsItem(
                            title: "التوقيت الصيفي",
                            hasSwitch: true,
                            switchValue: state.isDaylightSavingEnabled,
                            onSwitchChanged: (value) {
                              context
                                  .read<SettingsCubit>()
                                  .toggleDaylightSaving(value);
                            },
                          ),
                          CustomSettingsItem(
                            title: " الوضع الليلى",
                            hasSwitch: true,
                            switchValue: state.isDarkModeEnabled,
                            onSwitchChanged: (value) {
                              themeCubit.toggleTheme();
                              context
                                  .read<SettingsCubit>()
                                  .toggleThemeSaving(value);
                            },
                          ),
                        ],
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'اختر الدولة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...cubit.availableCountries.map(
              (country) => ListTile(
                title: Text(country, textAlign: TextAlign.right),
                onTap: () {
                  cubit.changeCountry(country);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'اختر اللغة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...cubit.availableLanguages.map(
              (language) => ListTile(
                title: Text(language, textAlign: TextAlign.right),
                onTap: () {
                  cubit.changeLanguage(language);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
