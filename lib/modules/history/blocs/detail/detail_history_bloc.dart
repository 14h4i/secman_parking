import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secman_parking/modules/history/models/record.dart';
import 'package:secman_parking/modules/history/repos/history_repo.dart';

part 'detail_history_event.dart';
part 'detail_history_state.dart';

class DetailHistoryBloc extends Bloc<DetailHistoryEvent, DetailHistoryState> {
  DetailHistoryBloc() : super(DetailHistoryInitial()) {
    on<LoadDetail>(_onLoadDetail);
    on<SelectDay>(_onSelectDay);
  }

  _onLoadDetail(DetailHistoryEvent event, Emitter<DetailHistoryState> emit) {
    if (event is LoadDetail) {}
  }

  _onSelectDay(
      DetailHistoryEvent event, Emitter<DetailHistoryState> emit) async {
    if (event is SelectDay) {
      try {
        emit(DetailHistoryInitial());
        final records = await HistoryRepo()
            .getDetailHistory(event.docId, event.daySelected);
        emit(DetailHistoryLoaded(records));
      } catch (e) {
        emit(DetailHistoryFailure(error: e));
      }
    }
  }
}
