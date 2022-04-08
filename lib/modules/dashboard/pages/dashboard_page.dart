import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:secman_parking/common/widgets/statefull/app_drawer.dart';
import 'package:secman_parking/modules/guest/blocs/camera/camera_bloc.dart';
import 'package:secman_parking/modules/guest/blocs/guest/guest_bloc.dart';
import 'package:secman_parking/modules/guest/pages/guest_page.dart';
import 'package:secman_parking/modules/history/blocs/history_bloc.dart';
import 'package:secman_parking/modules/history/pages/history_page.dart';
import 'package:secman_parking/modules/internal/blocs/internal_bloc.dart';
import 'package:secman_parking/modules/internal/pages/internal_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool? _isConnected;
  int _index = 0;
  late StreamSubscription subscription;

  @override
  void initState() {
    subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          setState(() {
            _isConnected = true;
          });

          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            _isConnected = false;
          });
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  // final LogProvider _logProvider = const LogProvider('⚡️ Dashboard');
  final List<Widget> _children = [
    BlocProvider(
      create: (_) => InternalBloc(),
      child: const InternalPage(),
    ),
    BlocProvider(
      create: (context) => GuestBloc(BlocProvider.of<CameraBloc>(context)),
      child: const GuestPage(),
    ),
    BlocProvider(
      create: (_) => HistoryBloc()..add(GetHistories()),
      child: const HistoryPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index, // this will be set when a new tab is tapped
        iconSize: 36,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.business_outlined),
            label: 'Nội bộ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Khách',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          )
        ],
      ),
      body: _isConnected == true
          ? _children[_index]
          : const Center(
              child: AutoSizeText(
                'Không có kết nối mạng',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}
