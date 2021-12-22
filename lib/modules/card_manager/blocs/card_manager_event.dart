part of 'card_manager_bloc.dart';

abstract class CardManagerEvent extends Equatable {
  const CardManagerEvent();

  @override
  List<Object> get props => [];
}

class AddInternalCard extends CardManagerEvent {
  final Map<String, dynamic> mapValue;

  const AddInternalCard({required this.mapValue});

  @override
  List<Object> get props => [mapValue];
}
