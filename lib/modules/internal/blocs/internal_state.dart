part of 'internal_bloc.dart';

abstract class InternalState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScanInitial extends InternalState {}

class ScanLoading extends InternalState {}

class ScanSuccess extends InternalState {
  final Card? card;

  ScanSuccess({this.card});

  @override
  List<Object?> get props => [card];
}

class Failure extends InternalState {
  final Object? error;
  Failure({required this.error});

  @override
  List<Object?> get props => [error];
}

class SendInSuccess extends InternalState {
  final DateTime timeIn;
  final Card card;

  SendInSuccess({
    required this.timeIn,
    required this.card,
  });

  @override
  List<Object?> get props => [timeIn, card];
}

class SendOutSuccess extends InternalState {
  final DateTime timeOut;
  final Card card;

  SendOutSuccess({
    required this.timeOut,
    required this.card,
  });

  @override
  List<Object?> get props => [timeOut, card];
}
