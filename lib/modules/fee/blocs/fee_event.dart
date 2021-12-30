part of 'fee_bloc.dart';

abstract class FeeEvent extends Equatable {
  const FeeEvent();

  @override
  List<Object> get props => [];
}

class GetListFee extends FeeEvent {}
