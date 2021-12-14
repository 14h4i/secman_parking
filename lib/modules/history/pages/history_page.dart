import 'package:flutter/material.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/themes/app_themes.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: AppThemes.iconThemeAppBar,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('History'),
      ),
    );
  }
}
