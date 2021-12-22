part of 'add_internal_card_bloc.dart';

abstract class AddInternalCardEvent extends Equatable {
  const AddInternalCardEvent();

  @override
  List<Object> get props => [];
}

class AddInternalCard extends AddInternalCardEvent {
  final Map<String, dynamic> mapValue;

  const AddInternalCard({required this.mapValue});

  @override
  List<Object> get props => [mapValue];
}
