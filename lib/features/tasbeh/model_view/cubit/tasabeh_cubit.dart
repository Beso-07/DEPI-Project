import 'package:bloc/bloc.dart';
import 'package:depiproject/features/tasbeh/view/tasbeh.dart';
part 'tasabeh_state.dart';

class TasabehCubit extends Cubit<TasabehState> {
  TasabehCubit() : super(TasabehInitial());
  
void showcount(int counter){
  counter++;
  emit(setCount());
}
void resetCount(int counter){
  counter=0;
 emit(resetCounter());
}
void showZeker(String zekr,String currentZeker){
  currentZeker=zekr;
  emit(setZeker());
}
}
