part of 'add_internal_card_bloc.dart';

abstract class AddInternalCardState extends Equatable {
  const AddInternalCardState();

  @override
  List<Object> get props => [];
}

class CardManagerInitial extends AddInternalCardState {}

class AddInternalCardSuccess extends AddInternalCardState {}

class AddInternalCardFailure extends AddInternalCardState {}
