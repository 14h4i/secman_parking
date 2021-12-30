part of 'fee_bloc.dart';

abstract class FeeState extends Equatable {
  const FeeState();

  @override
  List<Object?> get props => [];
}

class FeeInitial extends FeeState {}

class FeeFailure extends FeeState {
  final Object? error;

  const FeeFailure({this.error});

  @override
  List<Object?> get props => [error];
}

class GetListFeeSuccess extends FeeState {
  final List<Fee> listFee;
  final int total;
  final int notCollected;
  final int collected;

  const GetListFeeSuccess({
    required this.listFee,
    required this.total,
    required this.collected,
    required this.notCollected,
  });

  @override
  List<Object?> get props => [listFee];
}
