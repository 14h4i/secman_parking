import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:secman_parking/common/widgets/statefull/app_drawer.dart';
import 'package:secman_parking/common/widgets/stateless/app_toast.dart';
import 'package:secman_parking/common/widgets/stateless/text_error.dart';
import 'package:secman_parking/modules/internal/blocs/internal_bloc.dart';
import 'package:secman_parking/modules/internal/widgets/button_in_out.dart';
import 'package:secman_parking/modules/internal/widgets/info_card_internal.dart';
import 'package:secman_parking/common/widgets/stateless/time_in_out.dart';
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
  final Color _backgroundColor = Colors.blue;

  final _nfc = NfcManager.instance;

  @override
  void initState() {
    _initTts();
    _startNfc();
    super.initState();
  }

  @override
  void dispose() {
    _nfc.stopSession();
    super.dispose();
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
        if (state is Failure) {
          child = TextError(error: state.error);
        }
        if (state is ScanSuccess) {
          final data = state.card;
          if (data != null) {
            _speak(data.vehicleNumber!);
            child = Column(
              children: [
                Expanded(
                  flex: 4,
                  child: InfoCardInternal(card: data),
                ),
                Expanded(
                  flex: 1,
                  child: ButtonInOut(
                    onPressedIn: () {
                      bloc!.add(SendInInternalCard(card: data));
                    },
                    onPressedOut: () {
                      bloc!.add(SendOutInternalCard(card: data));
                    },
                  ),
                )
              ],
            );
          } else {
            AppToast.showShortToast('Thẻ không có dữ liệu');
          }
        }

        if (state is SendInSuccess) {
          final data = state.card;
          child = Column(
            children: [
              Expanded(
                flex: 4,
                child: InfoCardInternal(card: data),
              ),
              Expanded(
                flex: 1,
                child: TimeInOut(
                  isIn: true,
                  timeIn: state.timeIn,
                  timeOut: data.timeOut,
                ),
              )
            ],
          );
        }

        if (state is SendOutSuccess) {
          final data = state.card;
          child = Column(
            children: [
              Expanded(
                flex: 4,
                child: InfoCardInternal(card: data),
              ),
              Expanded(
                flex: 1,
                child: TimeInOut(
                  isIn: false,
                  timeIn: data.timeIn,
                  timeOut: state.timeOut,
                ),
              )
            ],
          );
        }

        return Scaffold(
          backgroundColor: _backgroundColor,
          appBar: AppBar(
            iconTheme: AppThemes.iconThemeAppBar,
            backgroundColor: _backgroundColor,
            elevation: 0,
            // actions: [
            //   IconButton(
            //     onPressed: () async {
            //       bloc!.add(ScanInternalCard(id: 'abc002'));
            //     },
            //     icon: const Icon(Icons.send),
            //   )
            // ],
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

  void _startNfc() {
    _nfc.startSession(onDiscovered: (NfcTag tag) async {
      bloc!.add(ScanInternalCard(id: 'abc002'));
    });
  }

  Future<void> _speak(String number) async {
    final text = TextToSpeechUtil.vehicleToText(number);
    if (text != null) {
      _flutterTts.speak(text);
    }
  }
}
