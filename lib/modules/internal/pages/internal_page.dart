import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/modules/internal/blocs/internal_bloc.dart';
import 'package:secman_parking/modules/internal/widgets/info_card_internal.dart';
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
  Color _backgroundColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<card.Card?>(
        stream: bloc!.scanStream,
        builder: (context, snapshot) {
          Widget child = Container(
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
          if (snapshot.hasError) {
            child = Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data != null) {
              child = InfoCardInternal(card: data);
              if (data.timeIn == null) {
                _backgroundColor = Colors.redAccent;
              } else {
                _backgroundColor = Colors.green;
              }
            }
          } else {
            _backgroundColor = Colors.blue;
          }

          return Scaffold(
            backgroundColor: _backgroundColor,
            appBar: AppBar(
              iconTheme: AppThemes.iconThemeAppBar,
              backgroundColor: _backgroundColor,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () async {
                    bloc!.scan('abc001');
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            ),
            drawer: const AppDrawer(),
            body: child,
          );
        });
  }
}
