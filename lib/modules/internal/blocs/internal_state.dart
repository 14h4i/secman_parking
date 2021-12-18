part of 'internal_bloc.dart';

abstract class InternalState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialScanState extends InternalState {}

class ScanSuccessState extends InternalState {
  final Card? card;

  ScanSuccessState({this.card});

  @override
  List<Object?> get props => [card];
}

class ScanFailureState extends InternalState {
  final Object? error;
  ScanFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
