import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secman_parking/modules/card_manager/repos/add_internal_card_repo.dart';

part 'add_internal_card_event.dart';
part 'add_internal_card_state.dart';

class AddInternalCardBloc
    extends Bloc<AddInternalCardEvent, AddInternalCardState> {
  AddInternalCardBloc() : super(CardManagerInitial()) {
    on<AddInternalCard>(_addInternalCard);
  }

  Future<void> _addInternalCard(
      AddInternalCardEvent event, Emitter<AddInternalCardState> emit) async {
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
