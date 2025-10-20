import 'package:depiproject/features/ahadith/models/hadith_model.dart';

abstract class HadithState {}

class HadithInitial extends HadithState {}

class HadithLoading extends HadithState {}

class HadithSuccess extends HadithState {
  late final HadithModel hadith;
  final List<Hadith> savedHadith;
  HadithSuccess(this.hadith, this.savedHadith);
}

class HadithError extends HadithState {
  final String message;
  HadithError(this.message);
}
