import 'package:depiproject/core/helpers/json_helper.dart';
import 'package:depiproject/features/prophets/models/prophets_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'prophets_state.dart';

class ProphetsCubit extends Cubit<ProphetsState> {
  ProphetsCubit() : super(ProphetsInitial());

  Future<void> fetchProphets() async {
    emit(ProphetsLoading());
    try {
      final response =
          await JsonHelper.getJson(path: "assets/json/prophets.json");

      final data =
          (response as List).map((e) => ProphetsModel.fromJson(e)).toList();

      // await Future.delayed(const Duration(seconds: 2));
      emit(ProphetsSuccess(data));
    } catch (e) {
      emit(ProphetsFailure(e.toString()));
    }
  }
}
