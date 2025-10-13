import 'package:depiproject/core/helpers/json_helper.dart';
import 'package:depiproject/features/AsmaulHusna/model_view/cubit/asmaulHusna_cubit.dart';
import 'package:depiproject/features/AsmaulHusna/models/AsmaulHusna_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AsmaulHusnaCubit extends Cubit<AsmaulHusnaState> {
  AsmaulHusnaCubit() : super(AsmaulHusnaInitial());

  Future<void> fetchAsmaulHusna() async {
    emit(AsmaulHusnaLoading());
    try {
      final response =
          await JsonHelper.getJson(path: "assets/json/asmaul_husna.json");

      final data =
          (response as List).map((e) => AsmaulhusnaModel.fromJson(e)).toList();

      emit(AsmaulHusnaSuccess(data));
    } catch (e) {
      emit(AsmaulHusnaError(e.toString()));
    }
  }
}
