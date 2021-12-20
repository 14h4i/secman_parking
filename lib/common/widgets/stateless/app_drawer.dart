import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/blocs/app_bloc.dart';
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
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Name worker',
            ),
            accountEmail: const Text(
              'Bảo vệ',
              style: AppTextStyle.italic,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: CachedNetworkImage(
                imageUrl: '',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
          ListTile(
            title: const Text('Thông tin cá nhân'),
            leading: const Icon(Icons.person),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Hướng dẫn'),
            leading: const Icon(Icons.import_contacts),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Báo cáo sự cố'),
            leading: const Icon(Icons.report),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Cài đặt'),
            leading: const Icon(Icons.settings),
            onTap: () {},
          ),
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
