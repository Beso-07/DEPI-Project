part of 'azkar_view_cubit.dart';

@immutable
abstract class AzkarViewState {}

class AzkarViewInitial extends AzkarViewState {}

class AzkarViewLoading extends AzkarViewState {}

class AzkarViewSuccess extends AzkarViewState {
  final Azkar azkar;

  AzkarViewSuccess(this.azkar);
}

class AzkarViewError extends AzkarViewState {
  final String message;

  AzkarViewError(this.message);
}
