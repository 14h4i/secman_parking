part of 'guest_bloc.dart';

abstract class GuestState extends Equatable {
  const GuestState();

  @override
  List<Object?> get props => [];
}

class GuestInitial extends GuestState {}

class ScanedGuestCard extends GuestState {}

class ScanGuestCardFailure extends GuestState {
  final Object? error;

  const ScanGuestCardFailure({this.error});

  @override
  List<Object?> get props => [error];
}
