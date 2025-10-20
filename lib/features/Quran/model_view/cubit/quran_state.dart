part of 'quran_cubit.dart';

abstract class QuranState {}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranLoaded extends QuranState {
  final List<Surah> surahs;
  final List<Surah> savedSurahs; // ✅ أضفنا دي

  QuranLoaded(this.surahs, this.savedSurahs);
}

class QuranError extends QuranState {
  final String message;
  QuranError(this.message);
}
