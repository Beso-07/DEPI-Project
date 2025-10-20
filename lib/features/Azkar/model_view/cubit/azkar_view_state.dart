import 'package:depiproject/features/Azkar/models/Azkar_model.dart';

abstract class AzkarState {}

class AzkarInitial extends AzkarState {}

class AzkarLoading extends AzkarState {}

class AzkarSuccess extends AzkarState {
  final AzkarModel azkar;
  final List<Zekr> savedAzkar;

  AzkarSuccess({
    required this.azkar,
    required this.savedAzkar,
  });
}

class AzkarError extends AzkarState {
  final String message;
  AzkarError(this.message);
}
