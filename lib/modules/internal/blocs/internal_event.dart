part of 'internal_bloc.dart';

abstract class InternalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScanInternalCard extends InternalEvent {
  final String id;

  ScanInternalCard({required this.id});

  @override
  List<Object?> get props => [id];
}

class SendInInternalCard extends InternalEvent {
  final Card card;

  SendInInternalCard({required this.card});

  @override
  List<Object?> get props => [card];
}

class SendOutInternalCard extends InternalEvent {
  final Card card;

  SendOutInternalCard({required this.card});

  @override
  List<Object?> get props => [card];
}
