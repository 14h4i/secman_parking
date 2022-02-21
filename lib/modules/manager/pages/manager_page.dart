import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:secman_parking/common/widgets/stateless/text_error.dart';
import 'package:secman_parking/modules/manager/blocs/manager_bloc.dart';
import 'package:secman_parking/modules/manager/pages/internal_card_manager_page.dart';
import 'package:secman_parking/modules/manager/widgets/scan_nfc_bottom_sheet.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({Key? key}) : super(key: key);

  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  ManagerBloc? get bloc => BlocProvider.of<ManagerBloc>(context);

  final _nfc = NfcManager.instance;

  @override
  void initState() {
    _startNfc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerBloc, ManagerState>(
      builder: (context, state) {
        if (state is ManagerInitial) {
          return Scaffold(
            body: Center(
              child: ScanNfcBottomSheet(
                title: 'Quét thẻ Master',
                subTitle: 'Giữ điện thoại lại gần thẻ master',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        }

        if (state is CheckMasterCardComplete) {
          if (!state.status) {
            return Scaffold(
              body: Center(
                child: ScanNfcBottomSheet(
                  title: 'Quét thẻ Master',
                  subTitle: 'Giữ điện thoại lại gần thẻ master',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          }
        }

        if (state is ManagerFailure) {
          return Scaffold(
            body: TextError(error: state.error),
          );
        }

        return const InternalCardManagerPage();
      },
    );
  }

  void _startNfc() {
    _nfc.startSession(onDiscovered: (NfcTag tag) async {
      bloc!.add(CheckMasterCards(id: '${tag.data['nfca']['identifier']}'));
    });
  }
}
