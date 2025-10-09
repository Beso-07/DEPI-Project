import 'package:depiproject/core/helpers/json_helper.dart';
import 'package:depiproject/features/Azkar/model_view/cubit/azkar_view_state.dart';
import 'package:depiproject/features/Azkar/models/azkar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarInitial());

  Future<void> getAzkar() async {
    emit(AzkarLoading());

    try {
      final response = await JsonHelper.getJson(path: "assets/json/azkar.json");
      final azkar = AzkarModel.fromJson(response);
      emit(AzkarSuccess(azkar));
    } catch (e) {
      emit(AzkarError(e.toString()));
    }
  }
}
