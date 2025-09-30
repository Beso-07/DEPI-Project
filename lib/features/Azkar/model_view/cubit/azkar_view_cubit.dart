import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:depiproject/core/network/dio_helper.dart';
import 'package:meta/meta.dart';
import 'package:depiproject/features/Azkar/models/Azkar_model.dart';

part 'azkar_view_state.dart';

class AzkarViewCubit extends Cubit<AzkarViewState> {
  AzkarViewCubit() : super(AzkarViewInitial());

  Future<void> getAzkar() async {
    emit(AzkarViewLoading());
    try {
      final response = await DioHelper().getData(
        url:
            "https://raw.githubusercontent.com/nawafalqari/azkar-api/56df51279ab6eb86dc2f6202c7de26c8948331c1/azkar.json",
      );
      await Future.delayed(Duration(seconds: 3));
      if (response.statusCode == 200) {
        final azkar = Azkar.fromJson(response.data);

        emit(AzkarViewSuccess(azkar));
      } else {
        emit(AzkarViewError("Error: ${response.statusMessage}"));
      }
    } catch (e) {
      emit(AzkarViewError(e.toString()));
    }
  }
}
