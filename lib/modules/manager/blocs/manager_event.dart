part of 'manager_bloc.dart';

abstract class ManagerEvent extends Equatable {
  const ManagerEvent();

  @override
  List<Object> get props => [];
}

class GetCards extends ManagerEvent {}

class AddInternalCard extends ManagerEvent {
  final Map<String, dynamic> value;

  const AddInternalCard({required this.value});

  @override
  List<Object> get props => [value];
}
