import 'package:flutter/material.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/modules/history/pages/history_page.dart';
import 'package:secman_parking/modules/guest/blocs/guest_bloc.dart';
import 'package:secman_parking/modules/guest/pages/guest_page.dart';
import 'package:secman_parking/modules/internal/blocs/internal_bloc.dart';
import 'package:secman_parking/modules/internal/pages/internal_page.dart';
import 'package:secman_parking/providers/bloc_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _index = 0;
  final List<Widget> _children = [
    BlocProvider(
      bloc: InternalBloc(),
      child: const InternalPage(),
    ),
    BlocProvider(
      bloc: GuestBloc(),
      child: const GuestPage(),
    ),
    const HistoryPage(),
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
            icon: Icon(Icons.nfc),
            label: 'Khách',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          )
        ],
      ),
      body: _children[_index],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}
