part of 'guest_bloc.dart';

abstract class GuestEvent extends Equatable {
  const GuestEvent();

  @override
  List<Object> get props => [];
}

class ScanGuestCard extends GuestEvent {
  final String id;

  const ScanGuestCard({required this.id});

  @override
  List<Object> get props => [id];
}
