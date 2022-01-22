import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/common/widgets/statefull/app_drawer.dart';
import 'package:secman_parking/common/widgets/stateless/circular_progress_center.dart';
import 'package:secman_parking/common/widgets/stateless/floating_text_button.dart';
import 'package:secman_parking/common/widgets/stateless/text_error.dart';
import 'package:secman_parking/common/widgets/stateless/text_time_in_out.dart';
import 'package:secman_parking/main.dart';
import 'package:secman_parking/modules/guest/blocs/camera/camera_bloc.dart';
import 'package:secman_parking/modules/guest/blocs/guest/guest_bloc.dart';
import 'package:secman_parking/common/widgets/stateless/time_in_out.dart';
import 'package:secman_parking/themes/app_text_style.dart';
import 'package:secman_parking/themes/app_themes.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({Key? key}) : super(key: key);

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> with WidgetsBindingObserver {
  CameraBloc? get cameraBloc => BlocProvider.of<CameraBloc>(context);
  GuestBloc? get bloc => BlocProvider.of<GuestBloc>(context);
  final _backgroudColor = Colors.blue;

  @override
  void initState() {
    // onNewCameraSelected(cameras[0]);
    cameraBloc!.add(NewCamera(cameraDescription: cameras[0]));
    super.initState();
  }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    cameraBloc!.add(ChangeAppLifecycle(appLifecycleState: appLifecycleState));

    super.didChangeAppLifecycleState(appLifecycleState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _backgroudColor,
        iconTheme: AppThemes.iconThemeAppBar,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              bloc!.add(const ScanGuestCard(id: 'aaa002'));
            },
            icon: const Icon(Icons.camera_alt),
          ),
          IconButton(
            onPressed: () async {
              bloc!.add(ResetPage());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: _backgroudColor,
      drawer: const AppDrawer(),
      body: BlocBuilder<GuestBloc, GuestState>(
        bloc: bloc,
        builder: (context, stateGuest) => BlocBuilder<CameraBloc, CameraState>(
            bloc: cameraBloc,
            builder: (context, stateCamera) {
              if (stateGuest is GuestFailure) {
                return TextError(error: stateGuest.error);
              }
              if (stateGuest is GuestInitial) {
                if (stateCamera is CameraInitialized) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CameraPreview(stateCamera.controller!),
                  );
                }
              }
              if (stateGuest is GuestInSuccess) {
                return Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(child: Image.file(stateGuest.file)),
                    ),
                    Expanded(
                      flex: 1,
                      child: FloatingTextButton(
                        backgroundColor: Colors.green,
                        content: 'VÀO',
                        onPressedIn: () {
                          bloc!.add(SendIn(
                            card: stateGuest.card!,
                            url: stateGuest.url!,
                            file: stateGuest.file,
                          ));
                        },
                      ),
                    ),
                  ],
                );
              }
              if (stateGuest is GuestOutSuccess) {
                return Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: stateGuest.card!.currentPhoto!,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FloatingTextButton(
                        backgroundColor: Colors.redAccent,
                        content: 'RA',
                        onPressedIn: () {
                          bloc!.add(SendOut(card: stateGuest.card!));
                        },
                      ),
                    ),
                  ],
                );
              }

              if (stateGuest is GuestSendedIn) {
                return Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Image.file(stateGuest.file),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: TextTimeInOut(
                          isIn: true,
                          time: stateGuest.timeIn,
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (stateGuest is GuestSendedOut) {
                return Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: stateGuest.card.currentPhoto!,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: AutoSizeText(
                          'Thu tiền: ${stateGuest.fee} VNĐ',
                          style: AppTextStyle.h2,
                        ),
                      ),
                    )),
                    Expanded(
                      flex: 1,
                      child: TimeInOut(
                        isIn: false,
                        timeIn: stateGuest.card.timeIn,
                        timeOut: stateGuest.timeOut,
                      ),
                    ),
                  ],
                );
              }

              return const CircularProgressCenter();
            }),
      ),
    );
  }
}
