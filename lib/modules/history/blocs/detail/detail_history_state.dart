part of 'detail_history_bloc.dart';

abstract class DetailHistoryState extends Equatable {
  const DetailHistoryState();

  @override
  List<Object> get props => [];
}

class DetailHistoryInitial extends DetailHistoryState {}

class DetailHistoryLoaded extends DetailHistoryState {
  final List<Record> records;

  const DetailHistoryLoaded(this.records);

  @override
  List<Object> get props => [records];
}

class DetailHistoryFailure extends DetailHistoryState {
  final Object error;

  const DetailHistoryFailure({required this.error});

  @override
  List<Object> get props => [error];
}
