import 'dart:convert';
import 'package:depiproject/core/helpers/hive_helper.dart';
import 'package:depiproject/features/ahadith/model_view/cubit/cubit/hadith_view_state.dart';
import 'package:depiproject/features/ahadith/models/hadith_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HadithCubit extends Cubit<HadithState> {
  HadithCubit() : super(HadithInitial());

  Future<void> getHadith() async {
    emit(HadithLoading());
    try {
      final String response =
          await rootBundle.loadString('assets/json/hadith.json');
      final data = jsonDecode(response);
      final hadith = HadithModel.fromJson(data);
      emit(HadithSuccess(hadith, HiveHelper.ahadith));
    } catch (e) {
      emit(HadithError(e.toString()));
    }
  }

  bool isSaved(Hadith hadith) => HiveHelper.isSaved(
      items: HiveHelper.ahadith, item: hadith, key: HiveHelper.ahadithKey);

  Future<void> toggleSave(Hadith hadith) async {
    await HiveHelper.toggleSaved(
      key: HiveHelper.ahadithKey,
      items: HiveHelper.ahadith,
      item: hadith,
    );
    await HiveHelper.getMyNotes();
    if (state is HadithSuccess) {
      final current = state as HadithSuccess;
      emit(HadithSuccess(current.hadith, List.from(HiveHelper.ahadith)));
    }
  }
}
