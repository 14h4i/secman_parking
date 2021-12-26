part of 'guest_bloc.dart';

abstract class GuestState extends Equatable {
  const GuestState();

  @override
  List<Object?> get props => [];
}

class GuestInitial extends GuestState {}

class InGuestSuccess extends GuestState {
  final String? url;
  final Card? card;

  const InGuestSuccess({required this.url, required this.card});

  @override
  List<Object?> get props => [url, card];
}

class OutGuestSuccess extends GuestState {
  final Card? card;

  const OutGuestSuccess({required this.card});

  @override
  List<Object?> get props => [card];
}

class GuestFailure extends GuestState {
  final Object? error;

  const GuestFailure({this.error});

  @override
  List<Object?> get props => [error];
}

// class UploadSuccess extends GuestState {
//   final String url;

//   const UploadSuccess({required this.url});

//   @override
//   List<Object?> get props => [url];
// }

// class UploadFailure extends GuestState {
//   final Object? error;

//   const UploadFailure({required this.error});

//   @override
//   List<Object?> get props => [error];
// }
