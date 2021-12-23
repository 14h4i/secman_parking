import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/manager/repos/add_internal_card_repo.dart';
import 'package:secman_parking/modules/manager/repos/get_internal_cards_repo.dart';

part 'manager_event.dart';
part 'manager_state.dart';

class ManagerBloc extends Bloc<ManagerEvent, ManagerState> {
  ManagerBloc() : super(ManagerInitial()) {
    on<GetInternalCards>(_onGetInternalCards);
    on<AddInternalCard>(_onAddInternalCard);
  }

  Future<void> _onGetInternalCards(
      ManagerEvent event, Emitter<ManagerState> emit) async {
    try {
      final res = await GetInternalCardsRepo().get();
      if (res != null) {
        emit(GetInternalCardsSuccess(cards: res));
      } else {
        emit(GetInternalCardsSuccess(cards: res));
      }
    } catch (e) {
      emit(GetInternalCardsFailure(error: e));
    }
  }

  Future<void> _onAddInternalCard(
      ManagerEvent event, Emitter<ManagerState> emit) async {
    try {
      if (event is AddInternalCard) {
        final value = event.value;
        AddInternalCardRepo().add(
          value['id'],
          value['vehicle_owner'],
          value['phone_number'],
          value['unit'],
          value['vehicle_type'],
          value['sub_vehicle'],
          value['vehicle_number'],
        );
      }
      emit(AddInternalCardSuccess());
      add(GetInternalCards());
    } catch (e) {
      emit(AddInternalCardFailure());
    }
  }
}
