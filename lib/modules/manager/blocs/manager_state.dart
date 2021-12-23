part of 'manager_bloc.dart';

abstract class ManagerState extends Equatable {
  const ManagerState();

  @override
  List<Object?> get props => [];
}

class ManagerInitial extends ManagerState {}

class GetCardsSuccess extends ManagerState {
  final List<Card>? internalCards;
  final List<String>? masterCards;

  const GetCardsSuccess({this.internalCards, this.masterCards});

  @override
  List<Object?> get props => [internalCards, masterCards];
}

class GetCardsFailure extends ManagerState {
  final Object? error;

  const GetCardsFailure({this.error});

  @override
  List<Object?> get props => [error];
}

class AddInternalCardSuccess extends ManagerState {}

class AddInternalCardFailure extends ManagerState {}
