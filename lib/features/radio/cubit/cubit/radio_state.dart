abstract class RadioState {}

class RadioInitial extends RadioState {}

class RadioLoading extends RadioState {}

class RadioPlaying extends RadioState {
  final String stationName;
  RadioPlaying(this.stationName);
}

class RadioStopped extends RadioState {}

class RadioError extends RadioState {
  final String message;
  RadioError(this.message);
}
