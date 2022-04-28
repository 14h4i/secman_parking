import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/common/widgets/statefull/app_drawer.dart';
import 'package:secman_parking/common/widgets/stateless/circular_progress_center.dart';
import 'package:secman_parking/common/widgets/stateless/text_error.dart';
import 'package:secman_parking/modules/history/blocs/history_bloc.dart';
import 'package:secman_parking/route/route_name.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử'),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryFailure) {
            return TextError(error: state.error);
          }

          if (state is HistorySuccess) {
            return ListView.builder(
              itemCount: state.cards != null ? state.cards!.length : 0,
              itemBuilder: (context, index) {
                final card = state.cards![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteName.detailHistory,
                        arguments: card,
                      );
                    },
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Center(
                          child: Text(
                            '${card.name}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const CircularProgressCenter(
            color: Colors.blue,
          );
        },
      ),
    );
  }
}
