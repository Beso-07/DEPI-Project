import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depiproject/core/helpers/hive_helper.dart';
import 'package:depiproject/features/Quran/services/saved_verses_service.dart';
import 'archive_state.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  ArchiveCubit() : super(ArchiveInitial());

  Future<void> loadArchives() async {
    emit(ArchiveLoading());
    await HiveHelper.getMyNotes();
    final savedVerses = SavedVersesService.getAllSavedVerses();
    emit(ArchiveLoaded(
        azkar: HiveHelper.azkar,
        ahadith: HiveHelper.ahadith,
        quranVerses: savedVerses,
        doaa: HiveHelper.doaa));
  }

  Future<void> refreshArchives() async {
    await loadArchives();
  }
}
