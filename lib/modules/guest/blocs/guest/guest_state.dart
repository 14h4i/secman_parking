part of 'guest_bloc.dart';

abstract class GuestState extends Equatable {
  const GuestState();

  @override
  List<Object?> get props => [];
}

class GuestInitial extends GuestState {}

class GuestLoading extends GuestState {}

class GuestInSuccess extends GuestState {
  final String? url;
  final File file;
  final Card? card;

  const GuestInSuccess(
      {required this.url, required this.card, required this.file});

  @override
  List<Object?> get props => [url, card, file];
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
  final File file;

  const GuestSendedIn({
    required this.timeIn,
    required this.card,
    required this.url,
    required this.file,
  });

  @override
  List<Object?> get props => [timeIn, card, url, file];
}

class GuestSendedOut extends GuestState {
  final DateTime timeOut;
  final Card card;
  final int fee;

  const GuestSendedOut({
    required this.timeOut,
    required this.card,
    required this.fee,
  });

  @override
  List<Object?> get props => [timeOut, card, fee];
}
