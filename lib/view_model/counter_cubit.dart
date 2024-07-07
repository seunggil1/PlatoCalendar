import 'package:flutter_bloc/flutter_bloc.dart';


class CounterCubit extends Cubit<int> {
  CounterCubit(int initialState) : super(initialState);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
  }

  void increment() {
    addError(Exception('increment error!'), StackTrace.current);
    emit(state + 1);
  }
}