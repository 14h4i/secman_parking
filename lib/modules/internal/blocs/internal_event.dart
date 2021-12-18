part of 'internal_bloc.dart';

abstract class InternalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScanInternalCardEvent extends InternalEvent {
  final String id;

  ScanInternalCardEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
