part of 'get_internal_cards_bloc.dart';

abstract class GetInternalCardsEvent extends Equatable {
  const GetInternalCardsEvent();

  @override
  List<Object> get props => [];
}

class GetInternalCards extends GetInternalCardsEvent {}
