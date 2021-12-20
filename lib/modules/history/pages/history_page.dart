import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/modules/history/blocs/history_bloc.dart';
import 'package:secman_parking/themes/app_themes.dart';
import 'package:secman_parking/utils/date_time_intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử'),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryFailure) {
            return Center(
              child: Text('${state.error}'),
            );
          }

          if (state is HistorySuccess) {
            return DataTable(
              columnSpacing: 0,
              dataRowHeight: 100,
              headingTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: width * .3,
                    child: const AutoSizeText('Thông tin'),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: width * .7,
                    child: const AutoSizeText('Lịch sử'),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                state.cards!.length,
                (index) {
                  final card = state.cards![index];
                  return DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          height: 80,
                          width: 100,
                          child: card.isGuest!
                              ? card.currentPhoto != null
                                  ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: card.currentPhoto!)
                                  : Container()
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 4),
                                    color: Colors.blue.shade200,
                                  ),
                                  child: Center(
                                    child: AutoSizeText(
                                      '${card.vehicleNumber}',
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      DataCell(
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  !card.gotInto!
                                      ? 'Vào: ${DateTimeIntl.dateTimeToString(card.timeIn!)}'
                                      : 'Ra: ${DateTimeIntl.dateTimeToString(card.timeOut!)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: !card.gotInto!
                                        ? Colors.green
                                        : Colors.redAccent,
                                  ),
                                ),
                                Text(
                                  !card.gotInto!
                                      ? 'Ra: ${DateTimeIntl.dateTimeToString(card.timeOut!)}'
                                      : 'Vào: ${DateTimeIntl.dateTimeToString(card.timeIn!)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: !card.gotInto!
                                        ? Colors.redAccent
                                        : Colors.green,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  );
                },
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
