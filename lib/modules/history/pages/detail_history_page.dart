import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/common/widgets/stateless/circular_progress_center.dart';
import 'package:secman_parking/common/widgets/stateless/text_center.dart';
import 'package:secman_parking/models/card.dart' as cardm;
import 'package:secman_parking/modules/history/blocs/detail/detail_history_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailHistoryPage extends StatefulWidget {
  final cardm.Card card;

  const DetailHistoryPage({Key? key, required this.card}) : super(key: key);

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  DetailHistoryBloc? get bloc => BlocProvider.of<DetailHistoryBloc>(context);

  DateTime selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.card.name}'),
          bottom: PreferredSize(
              child: TableCalendar(
                locale: 'vi_VI',
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2040, 3, 14),
                onFormatChanged: (format) {},
                focusedDay: DateTime.now(),
                currentDay: DateTime.now(),
                calendarFormat: CalendarFormat.week,
                selectedDayPredicate: (day) {
                  return isSameDay(selected, day);
                },
                onDaySelected: (selectedDay, focusedDay) async {
                  setState(() {
                    selected = selectedDay;
                  });
                  bloc!.add(
                    SelectDay(
                        daySelected: selectedDay, docId: widget.card.docId!),
                  );
                },
              ),
              preferredSize: const Size.fromHeight(130)),
        ),
        body: BlocBuilder<DetailHistoryBloc, DetailHistoryState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is DetailHistoryLoaded) {
              if (state.records.isNotEmpty) {
                return ListView.builder(
                    itemCount: state.records.length,
                    itemBuilder: (context, index) {
                      final record = state.records[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: SizedBox(
                          height: 200,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: record.photo != null
                                      ? CachedNetworkImage(
                                          imageUrl: record.photo!)
                                      : Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 2)),
                                          child: const Center(
                                              child: Text('Thẻ khách')),
                                        )),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    '${record.time}',
                                    style: TextStyle(
                                      color: record.status == 'in'
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text(
                    'Trống',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            }
            if (state is DetailHistoryFailure) {
              return TextCenter(content: '${state.error}');
            }

            return const CircularProgressCenter(
              color: Colors.blue,
            );
          },
        ));
  }
}
