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
    on<GetInternalCards>(_onGetInternalCards);
    on<AddInternalCard>(_onAddInternalCard);
    on<CheckMasterCards>(_onCheckMasterCards);
  }

  Future<void> _onGetInternalCards(
      ManagerEvent event, Emitter<ManagerState> emit) async {
    if (event is GetInternalCards) {
      try {
        final internalCards = await GetInternalCardsRepo().get();
        emit(GetInternalCardsSuccess(
          internalCards: internalCards,
        ));
      } catch (e) {
        emit(GetInternalCardsFailure(error: e));
      }
    }
  }

  Future<void> _onCheckMasterCards(
      ManagerEvent event, Emitter<ManagerState> emit) async {
    if (event is CheckMasterCards) {
      try {
        final masterCards = await GetMasterCardsRepo().get();
        if (masterCards != null) {
          emit(CheckMasterCardComplete(status: masterCards.contains(event.id)));
        } else {
          emit(const CheckMasterCardComplete(status: false));
        }
      } catch (e) {
        emit(GetMasterCardsFailure(error: e));
      }
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
