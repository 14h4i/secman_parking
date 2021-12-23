part of 'manager_bloc.dart';

abstract class ManagerState extends Equatable {
  const ManagerState();

  @override
  List<Object?> get props => [];
}

class ManagerInitial extends ManagerState {}

class GetCardsSuccess extends ManagerState {
  final List<Card>? cards;

  const GetCardsSuccess({this.cards});

  @override
  List<Object?> get props => [cards];
}

class GetCardsFailure extends ManagerState {
  final Object? error;

  const GetCardsFailure({this.error});

  @override
  List<Object?> get props => [error];
}

class AddInternalCardSuccess extends ManagerState {}

class AddInternalCardFailure extends ManagerState {}
