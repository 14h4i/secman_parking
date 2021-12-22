import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/common/widgets/stateless/app_toast.dart';
import 'package:secman_parking/modules/internal/blocs/internal_bloc.dart';
import 'package:secman_parking/modules/internal/widgets/info_card_internal.dart';
import 'package:secman_parking/themes/app_text_style.dart';
import 'package:secman_parking/themes/app_themes.dart';
import 'package:secman_parking/utils/text_to_speech_util.dart';

class InternalPage extends StatefulWidget {
  const InternalPage({Key? key}) : super(key: key);

  @override
  _InternalPageState createState() => _InternalPageState();
}

class _InternalPageState extends State<InternalPage> {
  InternalBloc? get bloc => BlocProvider.of<InternalBloc>(context);
  late FlutterTts _flutterTts;
  Color _backgroundColor = Colors.blue;

  @override
  void initState() {
    _initTts();
    super.initState();
  }

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
              style: AppTextStyle.largeTitleCard,
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
            _speak(data.vehicleNumber!);
            child = InfoCardInternal(card: data);
            _backgroundColor = Colors.green;
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
                  bloc!.add(ScanInternalCardEvent(id: 'kkkk001'));
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

  void _initTts() {
    _flutterTts = FlutterTts();
    _flutterTts.setLanguage('vi-VN');
  }

  Future<void> _speak(String number) async {
    final text = TextToSpeechUtil.vehicleToText(number);
    if (text != null) {
      _flutterTts.speak(text);
    }
  }
}
