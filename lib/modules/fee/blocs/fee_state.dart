part of 'fee_bloc.dart';

abstract class FeeState extends Equatable {
  const FeeState();
  
  @override
  List<Object> get props => [];
}

class FeeInitial extends FeeState {}
