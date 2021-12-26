import 'package:flutter/material.dart';

class CircularProgressCenter extends StatelessWidget {
  final Color color;
  const CircularProgressCenter({
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
