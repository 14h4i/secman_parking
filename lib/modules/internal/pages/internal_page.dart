import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/common/widgets/stateless/app_toast.dart';
import 'package:secman_parking/modules/internal/blocs/internal_bloc.dart';
import 'package:secman_parking/modules/internal/widgets/info_card_internal.dart';
import 'package:secman_parking/themes/app_themes.dart';

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
    return BlocBuilder<InternalBloc, InternalState>(
      builder: (context, state) {
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
        if (state is ScanFailureState) {
          child = Center(
            child: Text(state.error.toString()),
          );
        }
        if (state is ScanSuccessState) {
          final data = state.card;
          if (data != null) {
            child = InfoCardInternal(card: data);
            if (!data.gotInto!) {
              _backgroundColor = Colors.redAccent;
            } else {
              _backgroundColor = Colors.green;
            }
          } else {
            AppToast.showShortToast('Thẻ không có dữ liệu');
            _backgroundColor = Colors.blue;
          }
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
                  bloc!.add(ScanInternalCardEvent(id: 'abc001'));
                },
                icon: const Icon(Icons.send),
              )
            ],
          ),
          drawer: const AppDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: child,
          ),
        );
      },
    );
  }
}
