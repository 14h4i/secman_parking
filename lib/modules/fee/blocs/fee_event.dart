part of 'fee_bloc.dart';

abstract class FeeEvent extends Equatable {
  const FeeEvent();

  @override
  List<Object> get props => [];
}

class GetListFee extends FeeEvent {}

class CollectFees extends FeeEvent {
  final List<Fee> listFee;

  const CollectFees(this.listFee);

  @override
  List<Object> get props => [listFee];
}
