part of 'detail_history_bloc.dart';

abstract class DetailHistoryEvent extends Equatable {
  const DetailHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadDetail extends DetailHistoryEvent {}

class SelectDay extends DetailHistoryEvent {
  final DateTime daySelected;
  final String docId;

  const SelectDay({
    required this.daySelected,
    required this.docId,
  });

  @override
  List<Object> get props => [daySelected, docId];
}
