part of 'prayer_time_cubit.dart';

@immutable
sealed class PrayerTimeState {}

final class PrayerTimeInitial extends PrayerTimeState {}

final class PrayerTimeLoading extends PrayerTimeState {}

final class PrayerTimeFailure extends PrayerTimeState {
  final String errMessage;

  PrayerTimeFailure({required this.errMessage});
}

final class PrayerTimeSuccess extends PrayerTimeState {
  final PrayerTimeModel prayerTimeModel;

  PrayerTimeSuccess({required this.prayerTimeModel});
}
