import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/common/widgets/stateless/app_toast.dart';
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
    bloc!.add(GetInternalCards());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerBloc, ManagerState>(
      builder: (context, state) {
        Widget body = const Center(
          child: CircularProgressIndicator(),
        );
        if (state is GetInternalCardsFailure) {
          body = Center(
            child: Text('${state.error}'),
          );
        }
        if (state is GetInternalCardsSuccess) {
          final cards = state.internalCards;
          if (cards != null) {
            body = SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return Container(
                    color:
                        (index) % 2 != 0 ? Colors.grey.shade200 : Colors.white,
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
            body = Container();
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Quản lý thẻ nội bộ'),
          ),
          body: body,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              // if (masterCards.contains('master1')) {
              //   Navigator.pop(context);
              //   showModalBottomSheet(
              //       context: context,
              //       backgroundColor: Colors.transparent,
              //       builder: (BuildContext context) {
              //         return ScanNfcBottomSheet(
              //           title: 'Quét thẻ cần thêm',
              //           subTitle: 'Giữ điện thoại lại gần thẻ cần thêm',
              //           onPressed: () {
              //             Navigator.pop(context);
              //           },
              //         );
              //       });
              //   await Future.delayed(const Duration(seconds: 3), () {});
              //   Navigator.pop(context);
              //   Navigator.pushNamed(context, RouteName.addInternalCardPage);
              // } else {
              //   AppToast.showShortToast('Thẻ master không đúng');
              // }
            },
          ),
        );
      },
    );
  }
}
