import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/card_manager/repos/get_internal_cards_repo.dart';

part 'get_internal_cards_event.dart';
part 'get_internal_cards_state.dart';

class GetInternalCardsBloc
    extends Bloc<GetInternalCardsEvent, GetInternalCardsState> {
  GetInternalCardsBloc() : super(GetInternalCardsInitial()) {
    on<GetInternalCards>(_onGetInternalCards);
  }

  Future<void> _onGetInternalCards(
      GetInternalCardsEvent event, Emitter<GetInternalCardsState> emit) async {
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
}
