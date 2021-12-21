import 'package:flutter/material.dart';
import 'package:secman_parking/modules/card_manager/widgets/scan_nfc_bottom_sheet.dart';
import 'package:secman_parking/route/route_name.dart';

class InternalCardManagerPage extends StatefulWidget {
  const InternalCardManagerPage({Key? key}) : super(key: key);

  @override
  _InternalCardManagerPageState createState() =>
      _InternalCardManagerPageState();
}

class _InternalCardManagerPageState extends State<InternalCardManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý thẻ nội bộ'),
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
