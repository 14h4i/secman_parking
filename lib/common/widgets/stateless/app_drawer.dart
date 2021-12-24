import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/blocs/app_bloc.dart';
import 'package:secman_parking/route/route_name.dart';
import 'package:secman_parking/themes/app_text_style.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  AppBloc? get appStateBloc => BlocProvider.of<AppBloc>(context);

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
            onTap: () {
              Navigator.pushNamed(context, RouteName.internalCardManagerPage);
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
