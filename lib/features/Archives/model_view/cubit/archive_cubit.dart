import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depiproject/core/helpers/hive_helper.dart';
import 'archive_state.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  ArchiveCubit() : super(ArchiveInitial());

  Future<void> loadArchives() async {
    emit(ArchiveLoading());
    await HiveHelper.getMyNotes();
    emit(ArchiveLoaded(
        azkar: HiveHelper.azkar,
        ahadith: HiveHelper.ahadith,
        quran: HiveHelper.quran,
        doaa: HiveHelper.doaa));
  }

  Future<void> refreshArchives() async {
    await loadArchives();
  }
}
