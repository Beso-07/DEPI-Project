import 'package:depiproject/features/Azkar/models/Azkar_model.dart';
import 'package:depiproject/features/Quran/models/quran_model.dart';
import 'package:depiproject/features/ahadith/models/hadith_model.dart';

abstract class ArchiveState {}

class ArchiveInitial extends ArchiveState {}

class ArchiveLoading extends ArchiveState {}

class ArchiveLoaded extends ArchiveState {
  final List<Zekr> azkar;
  final List<Hadith> ahadith;
  final List<Surah> quran;
  final List<Map<String, dynamic>> doaa;
  ArchiveLoaded({
    required this.doaa,
    required this.azkar,
    required this.ahadith,
    required this.quran,
  });
}
