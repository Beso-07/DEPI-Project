import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/settings/views/widgets/custom_settings_item.dart';
import 'package:flutter/material.dart';

class CustomSettings extends StatelessWidget {
  const CustomSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MainAppBar(title: "الاعدادات العامة"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomSettingsItem(
                    title: "الحساب الشخصي",
                    onTap: () {},
                  ),
                  CustomSettingsItem(
                    title: "الموقع الجغرافي",
                    optionalText: "تلقائي",
                    onTap: () {},
                  ),
                  CustomSettingsItem(
                    title: "اللغة",
                    optionalText: "عربية",
                    onTap: () {},
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
                    switchValue: true,
                    onSwitchChanged: (value) {},
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

