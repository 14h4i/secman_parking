part of 'manager_bloc.dart';

abstract class ManagerState extends Equatable {
  const ManagerState();

  @override
  List<Object?> get props => [];
}

class ManagerInitial extends ManagerState {}

class GetInternalCardsSuccess extends ManagerState {
  final List<Card>? cards;

  const GetInternalCardsSuccess({this.cards});

  @override
  List<Object?> get props => [cards];
}

class GetInternalCardsFailure extends ManagerState {
  final Object? error;

  const GetInternalCardsFailure({this.error});

  @override
  List<Object?> get props => [error];
}

class AddInternalCardSuccess extends ManagerState {}

class AddInternalCardFailure extends ManagerState {}
