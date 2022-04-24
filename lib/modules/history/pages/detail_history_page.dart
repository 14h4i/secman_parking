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
          title: Text('ID: ${widget.card.id}'),
          bottom: PreferredSize(
              child: TableCalendar(
                locale: 'vi_VI',
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2040, 3, 14),
                onFormatChanged: (format) {},
                focusedDay: DateTime.now(),
                calendarFormat: CalendarFormat.week,
                // onCalendarCreated: (PageController pageController) async {
                // if (_controller.firstTime) {
                //   await _controller.getDateFirst(_worker.listWorker);
                // }
                // },
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

                  // DialogBuilder(context).showLoadingIndicator(
                  //     'Vui lòng chờ...', 'Đang lấy thông tin ca trực');
                  // await _controller.onDaySelected(
                  //     selectedDay, focusedDay, _worker.listWorker);
                  // DialogBuilder(context).hideOpenDialog();
                },
              ),
              preferredSize: const Size.fromHeight(130)),
        ),
        body: BlocBuilder<DetailHistoryBloc, DetailHistoryState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is DetailHistoryLoaded) {
              return Text('cp');
            }
            if (state is DetailHistoryFailure) {
              return TextCenter(content: '${state.error}');
            }

            return const CircularProgressCenter();
          },
        ));
  }
}
