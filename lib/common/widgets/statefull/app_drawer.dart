import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/blocs/app_bloc.dart';
import 'package:secman_parking/common/widgets/stateless/app_toast.dart';
import 'package:secman_parking/modules/manager/blocs/manager_bloc.dart';
import 'package:secman_parking/modules/manager/widgets/scan_nfc_bottom_sheet.dart';
import 'package:secman_parking/route/route_name.dart';
import 'package:secman_parking/themes/app_text_style.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  AppBloc? get appStateBloc => BlocProvider.of<AppBloc>(context);
  ManagerBloc? get bloc => BlocProvider.of<ManagerBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              'Name worker',
            ),
            accountEmail: Text(
              'Bảo vệ',
              style: AppTextStyle.italic,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              // child: CachedNetworkImage(
              //   imageUrl: '',
              //   progressIndicatorBuilder: (context, url, downloadProgress) =>
              //       CircularProgressIndicator(value: downloadProgress.progress),
              //   errorWidget: (context, url, error) =>
              //       const Icon(Icons.error, color: Colors.red),
              // ),
            ),
          ),

          ListTile(
            title: const Text('Quản lý thẻ nội bộ'),
            leading: const Icon(Icons.manage_search),
            onTap: () async {
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
              bloc!.add(const CheckMasterCards(id: 'master1'));
              await Future.delayed(const Duration(seconds: 3), () {});
              if (bloc!.state is CheckMasterCardComplete) {
                if ((bloc!.state as CheckMasterCardComplete).status) {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                      context, RouteName.internalCardManagerPage);
                } else {
                  AppToast.showShortToast('Thẻ master không đúng');
                }
              }

              // if (masterCards.contains('master1')) {
              // Navigator.pop(context);
              // showModalBottomSheet(
              //     context: context,
              //     backgroundColor: Colors.transparent,
              //     builder: (BuildContext context) {
              //       return ScanNfcBottomSheet(
              //         title: 'Quét thẻ cần thêm',
              //         subTitle: 'Giữ điện thoại lại gần thẻ cần thêm',
              //         onPressed: () {
              //           Navigator.pop(context);
              //         },
              //       );
              //     });
              // await Future.delayed(const Duration(seconds: 3), () {});

              // Navigator.pushNamed(context, RouteName.addInternalCardPage);
              // } else {
              //   AppToast.showShortToast('Thẻ master không đúng');
              // }
            },
          ),

          // ListTile(
          //   title: const Text('Cài đặt'),
          //   leading: const Icon(Icons.settings),
          //   onTap: () {},
          // ),
          const Divider(),
          ListTile(
            title: const Text('Đăng xuất'),
            leading: const Icon(Icons.exit_to_app),
            onTap: _changeAppState,
          ),
          const Expanded(
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Version: ...',
                    style: AppTextStyle.italic,
                  )))
        ],
      ),
    );
  }

  void _changeAppState() {
    appStateBloc!.add(LogoutEvent());
  }
}
