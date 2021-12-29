import 'package:flutter/material.dart';
import 'package:secman_parking/common/widgets/statefull/app_drawer.dart';

class FeePage extends StatefulWidget {
  const FeePage({Key? key}) : super(key: key);

  @override
  _FeePageState createState() => _FeePageState();
}

class _FeePageState extends State<FeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý tiền'),
      ),
      drawer: const AppDrawer(),
      body: Container(),
    );
  }
}
