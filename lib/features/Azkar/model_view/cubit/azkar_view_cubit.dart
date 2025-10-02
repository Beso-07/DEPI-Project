import 'dart:convert';

import 'package:depiproject/features/Azkar/model_view/cubit/azkar_view_state.dart';
import 'package:depiproject/features/Azkar/models/Azkar_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarInitial());

  Future<void> getAzkar() async {
    emit(AzkarLoading());
    await Future.delayed(const Duration(seconds: 5));
    try {
      final String response =
          await rootBundle.loadString('assets/json/azkar.json');
      final data = jsonDecode(response);
      final azkar = AzkarModel.fromJson(data);
      emit(AzkarSuccess(azkar));
    } catch (e) {
      emit(AzkarError(e.toString()));
    }
  }
}
