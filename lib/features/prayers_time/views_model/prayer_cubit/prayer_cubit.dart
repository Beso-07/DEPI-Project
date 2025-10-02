import 'package:adhan/adhan.dart';
import 'package:depiproject/core/services/location_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depiproject/features/prayers_time/models/prayer_time_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(PrayerInitial());
  Future<void> getPrayerTimes() async {
    emit(PrayerLoading());
    try {
      Position position = await LocationService.getCurrentLocation();
      final lat = position.latitude;
      final long = position.longitude;

      final coordinates = Coordinates(lat, long);

      final params = CalculationMethod.egyptian.getParameters();
      final prayerTimes = PrayerTimes.today(coordinates, params);

      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      final place = placemarks.first;
      final city = place.locality ?? place.administrativeArea ?? "";
      final country = place.country ?? "";

      final model = PrayerTimeModel(
        fajr: formatTime(prayerTimes.fajr),
        sunrise: formatTime(prayerTimes.sunrise),
        dhuhr: formatTime(prayerTimes.dhuhr),
        asr: formatTime(prayerTimes.asr),
        maghrib: formatTime(prayerTimes.maghrib),
        isha: formatTime(prayerTimes.isha),
        city: city,
        country: country,
      );

      emit(PrayerLoaded(model));
    } catch (e) {
      emit(PrayerError(e.toString()));
    }
  }

  String formatTime(DateTime dateTime) {
    int hour = dateTime.hour + 1;
    int minute = dateTime.minute;

    String period = hour >= 12 ? 'م' : 'ص';

    hour = hour % 12;
    if (hour == 0) hour = 12;

    final formattedMinute = minute.toString().padLeft(2, '0');
    return '$hour:$formattedMinute $period';
  }
}
