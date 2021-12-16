import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/modules/internal/blocs/internal_bloc.dart';
import 'package:secman_parking/providers/bloc_provider.dart';
import 'package:secman_parking/themes/app_themes.dart';
import 'package:secman_parking/models/card.dart' as card;

class InternalPage extends StatefulWidget {
  const InternalPage({Key? key}) : super(key: key);

  @override
  _InternalPageState createState() => _InternalPageState();
}

class _InternalPageState extends State<InternalPage> {
  InternalBloc? get bloc => BlocProvider.of<InternalBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: AppThemes.iconThemeAppBar,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              bloc!.scan('abc001a');
            },
            icon: const Icon(Icons.send),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: StreamBuilder<card.Card?>(
          stream: bloc!.scanStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.hasData) {
              final data = snapshot.data;
              if (data!.id != '-1') {
                return Center(
                  child: Text(snapshot.data.toString()),
                );
              } else {
                return const Center(
                  child: Text('Thẻ không có dữ liệu'),
                );
              }
            }

            return Container(
              color: Colors.blue,
              child: const Center(
                child: AutoSizeText(
                  'Hãy quét thẻ...',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
