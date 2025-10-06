import 'package:bloc/bloc.dart';
import 'package:depiproject/features/tasbeh/view/tasbeh.dart';
part 'tasabeh_state.dart';

class TasabehCubit extends Cubit<TasabehState> {
  TasabehCubit() : super(TasabehInitial());

  int counter = 0;
  String currentZeker = " اَسْتَغْفِرُ اللَّهَ";
  void showcount() {
    counter++;
    emit(setCount());
  }

  void resetCount() {
    counter = 0;
    emit(resetCounter());
  }

  void showZeker(String zekr) {
    currentZeker = zekr;
    counter = 0;
    emit(setZeker());
    emit(resetCounter());
  }
}
