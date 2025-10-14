import 'package:depiproject/core/helpers/hive_helper.dart';
import 'package:depiproject/core/helpers/json_helper.dart';
import 'package:depiproject/features/Azkar/model_view/cubit/azkar_view_state.dart';
import 'package:depiproject/features/Azkar/models/Azkar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarInitial());

  Future<void> getAzkar() async {
    emit(AzkarLoading());
    try {
      final response = await JsonHelper.getJson(path: "assets/json/azkar.json");
      final azkar = AzkarModel.fromJson(response);

      await HiveHelper.getMyNotes();

      emit(AzkarSuccess(azkar: azkar, savedAzkar: HiveHelper.azkar));
    } catch (e) {
      emit(AzkarError(e.toString()));
    }
  }

  bool isSaved(Zekr zekr) => HiveHelper.isAzkarSaved(zekr);

  /// 👇 دالة جديدة لتبديل الحفظ وإصدار حالة جديدة
  Future<void> toggleSave(Zekr zekr) async {
    await HiveHelper.toggleAzkar(zekr);
    if (state is AzkarSuccess) {
      final current = state as AzkarSuccess;
      emit(AzkarSuccess(
        azkar: current.azkar,
        savedAzkar: List.from(HiveHelper.azkar),
      ));
    }
  }
}
