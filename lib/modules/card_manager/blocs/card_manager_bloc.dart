import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secman_parking/modules/card_manager/repos/add_internal_card_repo.dart';

part 'card_manager_event.dart';
part 'card_manager_state.dart';

class CardManagerBloc extends Bloc<CardManagerEvent, CardManagerState> {
  CardManagerBloc() : super(CardManagerInitial()) {
    on<AddInternalCard>(_addInternalCard);
  }

  Future<void> _addInternalCard(
      CardManagerEvent event, Emitter<CardManagerState> emit) async {
    try {
      if (event is AddInternalCard) {
        final value = event.mapValue;
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
    } catch (e) {
      emit(AddInternalCardFailure());
    }
  }
}
