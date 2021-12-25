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

class GetInternalCardsFailure extends ManagerState {
  final Object? error;

  const GetInternalCardsFailure({this.error});

  @override
  List<Object?> get props => [error];
}

// class GetMasterCardsSuccess extends ManagerState {
//   final List<String>? masterCards;

//   const GetMasterCardsSuccess({this.masterCards});

//   @override
//   List<Object?> get props => [masterCards];
// }

class GetMasterCardsFailure extends ManagerState {
  final Object? error;

  const GetMasterCardsFailure({this.error});

  @override
  List<Object?> get props => [error];
}

class CheckMasterCardComplete extends ManagerState {
  final bool status;

  const CheckMasterCardComplete({required this.status});

  @override
  List<Object?> get props => [status];
}

class AddInternalCardSuccess extends ManagerState {}

class AddInternalCardFailure extends ManagerState {}
