import 'package:depiproject/core/helpers/hive_helper.dart';
import 'package:depiproject/core/services/location_service.dart';
import 'package:depiproject/features/settings/model_view/cubit/theme_cubit.dart';
import 'package:depiproject/features/home/views/home_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  LocationService.getCurrentLocation();
  await HiveHelper.init();

  // runApp(DevicePreview(builder: (context) => const IslamicApp()));
  // await initTimeZone();
  //  await ShowLocalNotification().initNotification();

  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: DevicePreview(
        builder: (context) => const IslamicApp(),
      ),
    ),
  );
}

class IslamicApp extends StatelessWidget {
  const IslamicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          locale: const Locale('ar'),
          supportedLocales: const [
            Locale('en'),
            Locale('ar', 'SA'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const HomeView(),
        );
      },
    );
  }
}
