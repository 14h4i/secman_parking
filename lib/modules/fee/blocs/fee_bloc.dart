import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fee_event.dart';
part 'fee_state.dart';

class FeeBloc extends Bloc<FeeEvent, FeeState> {
  FeeBloc() : super(FeeInitial()) {
    on<FeeEvent>((event, emit) {});
  }
}
