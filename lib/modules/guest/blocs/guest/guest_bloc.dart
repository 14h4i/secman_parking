import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'guest_event.dart';
part 'guest_state.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  GuestBloc() : super(GuestInitial()) {
    on<GuestEvent>((event, emit) {});
  }
}
