import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/internal/repos/internal_repo.dart';

part 'internal_event.dart';
part 'internal_state.dart';

class InternalBloc extends Bloc<InternalEvent, InternalState> {
  InternalBloc() : super(InitialScanState()) {
    on<ScanInternalCardEvent>(_scan);
  }

  Future<void> _scan(InternalEvent event, Emitter<InternalState> emit) async {
    try {
      if (event is ScanInternalCardEvent) {
        final res = await InternalRepo().scan(event.id);

        // _scanCtrl.sink.add(res);
        emit(ScanSuccessState(card: res));

        // _scanCtrl.sink.add(null);
        // emit(ScanSuccessState());
        // AppToast.showShortToast('Thẻ không có dữ liệu');

      }
    } catch (e) {
      // _scanCtrl.sink.addError(e);
      emit(ScanFailureState(error: e));
    }
  }
}
