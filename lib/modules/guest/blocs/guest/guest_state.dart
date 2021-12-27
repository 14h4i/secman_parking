part of 'guest_bloc.dart';

abstract class GuestState extends Equatable {
  const GuestState();

  @override
  List<Object?> get props => [];
}

class GuestInitial extends GuestState {}

class GuestInSuccess extends GuestState {
  final String? url;
  final Card? card;

  const GuestInSuccess({required this.url, required this.card});

  @override
  List<Object?> get props => [url, card];
}

class GuestOutSuccess extends GuestState {
  final Card? card;

  const GuestOutSuccess({required this.card});

  @override
  List<Object?> get props => [card];
}

class GuestFailure extends GuestState {
  final Object? error;

  const GuestFailure({this.error});

  @override
  List<Object?> get props => [error];
}

class GuestSendedIn extends GuestState {
  final DateTime timeIn;

  const GuestSendedIn({required this.timeIn});

  @override
  List<Object?> get props => [timeIn];
}

class GuestSendedOut extends GuestState {
  final DateTime timeOut;

  const GuestSendedOut({required this.timeOut});

  @override
  List<Object?> get props => [timeOut];
}
