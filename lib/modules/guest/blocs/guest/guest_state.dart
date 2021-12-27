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
  final Card card;
  final String url;

  const GuestSendedIn({
    required this.timeIn,
    required this.card,
    required this.url,
  });

  @override
  List<Object?> get props => [timeIn, card, url];
}

class GuestSendedOut extends GuestState {
  final DateTime timeOut;
  final Card card;

  const GuestSendedOut({
    required this.timeOut,
    required this.card,
  });

  @override
  List<Object?> get props => [timeOut, card];
}
