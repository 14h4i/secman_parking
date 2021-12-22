part of 'get_internal_cards_bloc.dart';

abstract class GetInternalCardsState extends Equatable {
  const GetInternalCardsState();

  @override
  List<Object?> get props => [];
}

class GetInternalCardsInitial extends GetInternalCardsState {}

class GetInternalCardsSuccess extends GetInternalCardsState {
  final List<Card>? cards;

  const GetInternalCardsSuccess({this.cards});

  @override
  List<Object?> get props => [cards];
}

class GetInternalCardsFailure extends GetInternalCardsState {
  final Object? error;

  const GetInternalCardsFailure({this.error});

  @override
  List<Object?> get props => [error];
}
