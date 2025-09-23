import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depiproject/core/network/dio_helper.dart';
import 'package:depiproject/core/services/location_service.dart';
import 'package:depiproject/features/prayer_time/models/prayer_time_model/prayer_time_model.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'prayer_time_state.dart';

class PrayerTimeCubit extends Cubit<PrayerTimeState> {
  PrayerTimeCubit() : super(PrayerTimeInitial());
  Future<void> getPrayerTimes() async {
    emit(PrayerTimeLoading());
    try {
      Position position = await LocationService.getCurrentLocation();

      final lat = position.latitude;
      final long = position.longitude;
      log(lat.toString());
      log(long.toString());
      var address =
          await GeoCode().reverseGeocoding(latitude: lat, longitude: long);
      log(address.city.toString());
      final now = DateTime.now();
      final date = "${now.day.toString().padLeft(2, '0')}-"
          "${now.month.toString().padLeft(2, '0')}-"
          "${now.year}";

      final response = await DioHelper().getData(
        url:
            "https://api.aladhan.com/v1/timingsByAddress/$date?address=$lat,$long",
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final model = PrayerTimeModel.fromJson(data);
        emit(PrayerTimeSuccess(prayerTimeModel: model));
      } else {
        emit(PrayerTimeFailure(
            errMessage:
                'Error: ${response.statusCode} - ${response.statusMessage}'));
      }
    } catch (e) {
      emit(PrayerTimeFailure(errMessage: e.toString()));
    }
  }
}
