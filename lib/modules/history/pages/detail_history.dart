import 'package:flutter/material.dart';
import 'package:secman_parking/models/card.dart' as cardm;

class DetailHistory extends StatelessWidget {
  final cardm.Card card;

  const DetailHistory({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin chi tiết'),
      ),
      body: Column(
        children: [
          Text('ID: ${card.id}'),
        ],
      ),
    );
  }
}
