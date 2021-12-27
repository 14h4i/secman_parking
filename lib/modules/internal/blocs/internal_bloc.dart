import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/internal/repos/internal_repo.dart';

part 'internal_event.dart';
part 'internal_state.dart';

class InternalBloc extends Bloc<InternalEvent, InternalState> {
  InternalBloc() : super(ScanInitial()) {
    on<ScanInternalCard>(_onScanInternalCard);
    on<SendInInternalCard>(_onSendInInternalCard);
    on<SendOutInternalCard>(_onSendOutInternalCard);
  }

  Future<void> _onScanInternalCard(
      InternalEvent event, Emitter<InternalState> emit) async {
    try {
      if (event is ScanInternalCard) {
        final res = await InternalRepo().getCard(event.id);
        emit(ScanSuccess(card: res));
      }
    } catch (e) {
      emit(Failure(error: e));
    }
  }

  Future<void> _onSendInInternalCard(
      InternalEvent event, Emitter<InternalState> emit) async {
    try {
      if (event is SendInInternalCard) {
        final timeIn = await InternalRepo().sendIn(event.card.docId!);
        emit(SendInSuccess(timeIn: timeIn, card: event.card));
      }
    } catch (e) {
      emit(Failure(error: e));
    }
  }

  Future<void> _onSendOutInternalCard(
      InternalEvent event, Emitter<InternalState> emit) async {
    try {
      if (event is SendOutInternalCard) {
        final timeOut = await InternalRepo().sendOut(event.card.docId!);
        emit(SendOutSuccess(timeOut: timeOut, card: event.card));
      }
    } catch (e) {
      emit(Failure(error: e));
    }
  }
}
