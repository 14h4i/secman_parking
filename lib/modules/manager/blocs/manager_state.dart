part of 'manager_bloc.dart';

abstract class ManagerState extends Equatable {
  const ManagerState();

  @override
  List<Object?> get props => [];
}

class ManagerInitial extends ManagerState {}

class GetInternalCardsSuccess extends ManagerState {
  final List<Card>? internalCards;

  const GetInternalCardsSuccess({this.internalCards});

  @override
  List<Object?> get props => [internalCards];
}

class ManagerFailure extends ManagerState {
  final Object? error;

  const ManagerFailure({this.error});

  @override
  List<Object?> get props => [error];
}

// class GetMasterCardsSuccess extends ManagerState {
//   final List<String>? masterCards;

//   const GetMasterCardsSuccess({this.masterCards});

//   @override
//   List<Object?> get props => [masterCards];
// }

class CheckMasterCardComplete extends ManagerState {
  final bool status;

  const CheckMasterCardComplete({required this.status});

  @override
  List<Object?> get props => [status];
}

class CheckNewCardComplete extends ManagerState {
  final bool status;

  const CheckNewCardComplete({required this.status});

  @override
  List<Object?> get props => [status];
}

class AddInternalCardSuccess extends ManagerState {}

class PressAddState extends ManagerState {}
