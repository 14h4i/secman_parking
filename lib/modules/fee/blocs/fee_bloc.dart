import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secman_parking/modules/fee/models/fee.dart';
import 'package:secman_parking/modules/fee/repos/fee_repo.dart';

part 'fee_event.dart';
part 'fee_state.dart';

class FeeBloc extends Bloc<FeeEvent, FeeState> {
  FeeBloc() : super(FeeInitial()) {
    on<GetListFee>(_onGetListFee);
    on<CollectFees>(_onCollectFees);
  }

  Future<void> _onGetListFee(FeeEvent event, Emitter<FeeState> emit) async {
    if (event is GetListFee) {
      try {
        final listFee = await FeeRepo().getListFee();
        int total = 0;
        int notCollected = 0;
        int collected = 0;
        if (listFee.isNotEmpty) {
          for (var fee in listFee) {
            total += fee.fee!;
            if (fee.collected!) {
              collected += fee.fee!;
            }
          }
          notCollected = total - collected;
        }
        emit(
          GetListFeeSuccess(
            listFee: listFee,
            total: total,
            collected: collected,
            notCollected: notCollected,
          ),
        );
      } catch (e) {
        emit(FeeFailure(error: e));
      }
    }
  }

  Future<void> _onCollectFees(FeeEvent event, Emitter<FeeState> emit) async {
    if (event is CollectFees) {
      try {
        FeeRepo().collectFees(event.listFee);

        add(GetListFee());
      } catch (e) {
        emit(FeeFailure(error: e));
      }
    }
  }
}
