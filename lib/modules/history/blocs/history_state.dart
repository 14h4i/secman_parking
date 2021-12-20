part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistorySuccess extends HistoryState {
  final List<Card>? cards;

  const HistorySuccess({this.cards});

  @override
  List<Object?> get props => [cards];
}

class HistoryFailure extends HistoryState {
  final Object? error;

  const HistoryFailure({this.error});

  @override
  List<Object?> get props => [error];
}
