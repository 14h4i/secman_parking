import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/history/repos/history_repo.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<GetHistories>(_getHistories);
  }

  Future<void> _getHistories(
      HistoryEvent event, Emitter<HistoryState> emit) async {
    try {
      final res = await HistoryRepo().getHistories();

      if (res != null) {
        emit(HistorySuccess(cards: res));
      } else {
        emit(const HistorySuccess(cards: []));
      }
    } catch (e) {
      emit(HistoryFailure(error: e));
    }
  }
}
