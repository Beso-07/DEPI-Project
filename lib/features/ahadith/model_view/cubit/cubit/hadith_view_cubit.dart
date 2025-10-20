import 'dart:convert';
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
      emit(HadithSuccess(hadith));
    } catch (e) {
      emit(HadithError(e.toString()));
    }
  }
}
