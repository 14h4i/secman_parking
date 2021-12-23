import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/manager/repos/add_internal_card_repo.dart';
import 'package:secman_parking/modules/manager/repos/get_internal_cards_repo.dart';
import 'package:secman_parking/modules/manager/repos/get_master_cards_repo.dart';

part 'manager_event.dart';
part 'manager_state.dart';

class ManagerBloc extends Bloc<ManagerEvent, ManagerState> {
  ManagerBloc() : super(ManagerInitial()) {
    on<GetCards>(_onGetCards);
    on<AddInternalCard>(_onAddInternalCard);
  }

  Future<void> _onGetCards(
      ManagerEvent event, Emitter<ManagerState> emit) async {
    try {
      final internalCards = await GetInternalCardsRepo().get();
      final masterCards = await GetMasterCardsRepo().get();
      emit(GetCardsSuccess(
        internalCards: internalCards,
        masterCards: masterCards,
      ));
    } catch (e) {
      emit(GetCardsFailure(error: e));
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
      add(GetCards());
    } catch (e) {
      emit(AddInternalCardFailure());
    }
  }
}
