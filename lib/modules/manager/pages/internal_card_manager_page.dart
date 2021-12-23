import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/modules/manager/blocs/manager_bloc.dart';
import 'package:secman_parking/modules/manager/widgets/scan_nfc_bottom_sheet.dart';
import 'package:secman_parking/route/route_name.dart';

class InternalCardManagerPage extends StatefulWidget {
  const InternalCardManagerPage({Key? key}) : super(key: key);

  @override
  _InternalCardManagerPageState createState() =>
      _InternalCardManagerPageState();
}

class _InternalCardManagerPageState extends State<InternalCardManagerPage> {
  ManagerBloc? get bloc => BlocProvider.of<ManagerBloc>(context);

  @override
  void initState() {
    bloc!.add(GetCards());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý thẻ nội bộ'),
      ),
      body: BlocBuilder<ManagerBloc, ManagerState>(
        builder: (context, state) {
          if (state is GetCardsFailure) {
            return Center(
              child: Text('${state.error}'),
            );
          }
          if (state is GetCardsSuccess) {
            final cards = state.cards;
            if (cards != null) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: (index) % 2 != 0
                          ? Colors.grey.shade200
                          : Colors.white,
                      child: ListTile(
                        style: ListTileStyle.drawer,
                        leading: Text('${index + 1}'),
                        title: Text('${cards[index].id}'),
                        trailing: Text('${cards[index].vehicleNumber}'),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return ScanNfcBottomSheet(
                title: 'Quét thẻ Master',
                subTitle: 'Giữ điện thoại lại gần thẻ master',
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          );
          await Future.delayed(const Duration(seconds: 3), () {
            Navigator.pop(context);
          });
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return ScanNfcBottomSheet(
                  title: 'Quét thẻ cần thêm',
                  subTitle: 'Giữ điện thoại lại gần thẻ cần thêm',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              });
          await Future.delayed(const Duration(seconds: 3), () {
            Navigator.pop(context);
          });
          Navigator.pushNamed(context, RouteName.addInternalCardPage);
        },
      ),
    );
  }
}
