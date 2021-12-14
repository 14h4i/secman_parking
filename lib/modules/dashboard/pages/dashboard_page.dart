import 'package:flutter/material.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/modules/calendar/pages/calendar_page.dart';
import 'package:secman_parking/modules/history/pages/history_page.dart';
import 'package:secman_parking/modules/home/pages/home_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _index = 1;
  final List<Widget> _children = const [
    CalendarPage(),
    HomePage(),
    HistoryPage(),
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
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
