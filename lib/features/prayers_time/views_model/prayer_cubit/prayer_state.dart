part of 'prayer_cubit.dart';

@immutable
sealed class PrayerState extends Equatable {
  const PrayerState();

  @override
  List<Object> get props => [];
}

class PrayerInitial extends PrayerState {}

class PrayerLoading extends PrayerState {}

class PrayerLoaded extends PrayerState {
  final PrayerTimeModel prayerTime;
  const PrayerLoaded(this.prayerTime);

  @override
  List<Object> get props => [prayerTime];
}

class PrayerError extends PrayerState {
  final String message;
  const PrayerError(this.message);

  @override
  List<Object> get props => [message];
}