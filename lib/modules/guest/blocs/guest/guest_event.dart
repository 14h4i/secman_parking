part of 'guest_bloc.dart';

abstract class GuestEvent extends Equatable {
  const GuestEvent();

  @override
  List<Object?> get props => [];
}

class ScanGuestCard extends GuestEvent {
  final String id;

  const ScanGuestCard({required this.id});

  @override
  List<Object> get props => [id];
}

class InGuest extends GuestEvent {
  final File? file;
  final Card? card;

  const InGuest({required this.file, required this.card});

  @override
  List<Object?> get props => [file, card];
}

class OutGuest extends GuestEvent {
  final Card? card;

  const OutGuest({required this.card});

  @override
  List<Object?> get props => [card];
}

class SendIn extends GuestEvent {
  final Card card;
  final String url;

  const SendIn({
    required this.card,
    required this.url,
  });

  @override
  List<Object?> get props => [card, url];
}

class SendOut extends GuestEvent {
  final Card card;

  const SendOut({
    required this.card,
  });

  @override
  List<Object?> get props => [card];
}
