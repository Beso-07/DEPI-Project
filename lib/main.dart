import 'package:depiproject/core/helpers/hive_helper.dart';
import 'package:depiproject/core/services/location_service.dart';
import 'package:depiproject/features/Archives/View/archive_view.dart';
import 'package:depiproject/features/Azkar/models/Azkar_model.dart';
import 'package:depiproject/features/home/views/home_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/splash/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveHelper.init();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ZekrAdapter());
  }

  await LocationService.getCurrentLocation();

  runApp(DevicePreview(builder: (context) => const IslamicApp()));
}

class IslamicApp extends StatelessWidget {
  const IslamicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('ar'),
      supportedLocales: [
        Locale('en'),
        Locale('ar', 'SA'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HomeView(),
    );
  }
}
