import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secman_parking/common/widgets/stateless/app_toast.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/guest/repos/guest_repo.dart';
import 'package:secman_parking/modules/internal/repos/internal_repo.dart';
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
    on<CheckNewCard>(_onCheckNewCard);
    on<PressAddButton>(_onPressAddButton);
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
        emit(ManagerFailure(error: e));
      }
    }
  }

  Future<void> _onCheckMasterCards(
      ManagerEvent event, Emitter<ManagerState> emit) async {
    if (event is CheckMasterCards) {
      try {
        final res = await GetMasterCardsRepo().check(event.id);
        if (res) {
          emit(const CheckMasterCardComplete(status: true));
        } else {
          AppToast.showShortToast('Thẻ không có dữ liệu');
          emit(const CheckMasterCardComplete(status: false));
        }
      } catch (e) {
        emit(ManagerFailure(error: e));
      }
    }
  }

  Future<void> _onCheckNewCard(
      ManagerEvent event, Emitter<ManagerState> emit) async {
    if (event is CheckNewCard) {
      try {
        final cM = await GetMasterCardsRepo().check(event.id);
        final cI = await InternalRepo().getCard(event.id);
        final cG = await GuestRepo().getCard(event.id);

        if (!cM && cI == null && cG == null) {
          emit(const CheckNewCardComplete(status: true));
        } else {
          AppToast.showShortToast('Thẻ đã tồn tại');
          emit(const CheckNewCardComplete(status: false));
        }
      } catch (e) {
        emit(ManagerFailure(error: e));
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
      emit(ManagerFailure(error: e));
    }
  }

  Future<void> _onPressAddButton(
      ManagerEvent event, Emitter<ManagerState> emit) async {
    if (event is PressAddButton) {
      emit(PressAddState());
    }
  }
}
