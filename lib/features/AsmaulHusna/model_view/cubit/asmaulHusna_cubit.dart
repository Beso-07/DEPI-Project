import 'package:depiproject/features/AsmaulHusna/models/AsmaulHusna_model.dart';

abstract class AsmaulHusnaState {}

class AsmaulHusnaInitial extends AsmaulHusnaState {}

class AsmaulHusnaLoading extends AsmaulHusnaState {}

class AsmaulHusnaSuccess extends AsmaulHusnaState {
  final List<AsmaulhusnaModel> names;
  AsmaulHusnaSuccess(this.names);
}

class AsmaulHusnaError extends AsmaulHusnaState {
  final String message;
  AsmaulHusnaError(this.message);
}
