import 'package:depiproject/features/Azkar/models/Azkar_model.dart';

abstract class AzkarState {}

class AzkarInitial extends AzkarState {}

class AzkarLoading extends AzkarState {}

class AzkarSuccess extends AzkarState {
  final AzkarModel azkar;
  AzkarSuccess(this.azkar);
}

class AzkarError extends AzkarState {
  final String message;
  AzkarError(this.message);
}
