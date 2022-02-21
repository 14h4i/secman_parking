part of 'manager_bloc.dart';

abstract class ManagerEvent extends Equatable {
  const ManagerEvent();

  @override
  List<Object> get props => [];
}

class GetInternalCards extends ManagerEvent {}

class CheckMasterCards extends ManagerEvent {
  final String id;

  const CheckMasterCards({required this.id});

  @override
  List<Object> get props => [id];
}

class CheckNewCard extends ManagerEvent {
  final String id;

  const CheckNewCard({required this.id});

  @override
  List<Object> get props => [id];
}

class PressAddButton extends ManagerEvent {}

class AddInternalCard extends ManagerEvent {
  final Map<String, dynamic> value;

  const AddInternalCard({required this.value});

  @override
  List<Object> get props => [value];
}
