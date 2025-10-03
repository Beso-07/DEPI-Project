import 'package:depiproject/features/ahadith/models/hadith_model.dart';

abstract class HadithState {}

class HadithInitial extends HadithState {}

class HadithLoading extends HadithState {}

class HadithSuccess extends HadithState {
  late final HadithModel hadith;
  HadithSuccess(this.hadith);
}

class HadithError extends HadithState {
  final String message;
  HadithError(this.message);
}
