import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/common/widgets/stateless/circular_progress_center.dart';
import 'package:secman_parking/common/widgets/stateless/floating_text_button.dart';
import 'package:secman_parking/common/widgets/stateless/text_error.dart';
import 'package:secman_parking/main.dart';
import 'package:secman_parking/modules/guest/blocs/camera/camera_bloc.dart';
import 'package:secman_parking/modules/guest/blocs/guest/guest_bloc.dart';
import 'package:secman_parking/modules/internal/widgets/button_in_out.dart';
import 'package:secman_parking/themes/app_text_style.dart';
import 'package:secman_parking/themes/app_themes.dart';
import 'package:auto_size_text/auto_size_text.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({Key? key}) : super(key: key);

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> with WidgetsBindingObserver {
  CameraBloc? get cameraBloc => BlocProvider.of<CameraBloc>(context);
  GuestBloc? get bloc => BlocProvider.of<GuestBloc>(context);
  final _backgroudColor = Colors.blue;
  // CameraController? controller;

  // File? _imageFile;

  // Initial values
  // bool _isCameraInitialized = false;

  // Current values
  // FlashMode? _currentFlashMode;

  // List<File> allFileList = [];

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
              icon: const Icon(Icons.camera_alt))
        ],
      ),
      backgroundColor: _backgroudColor,
      drawer: const AppDrawer(),
      body: BlocBuilder<GuestBloc, GuestState>(
        bloc: bloc,
        builder: (context, stateGuest) => BlocBuilder(
            bloc: cameraBloc,
            builder: (context, stateCamera) {
              if (stateGuest is GuestFailure) {
                return TextError(error: stateGuest.error);
              }
              if (stateGuest is GuestInitial) {
                if (stateCamera is CameraInitialized) {
                  return CameraPreview(stateCamera.controller!);
                }
              }
              if (stateGuest is InGuestSuccess) {
                if (stateCamera is TakePictureSuccess) {
                  return Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Center(child: Image.file(stateCamera.file!)),
                      ),
                      Expanded(
                        flex: 1,
                        child: FloatingTextButton(
                          backgroundColor: Colors.green,
                          content: 'VÀO',
                          onPressedIn: () {},
                        ),
                      ),
                    ],
                  );
                }
              }
              if (stateGuest is OutGuestSuccess) {
                return Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CachedNetworkImage(
                        imageUrl: stateGuest.card!.currentPhoto!,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FloatingTextButton(
                        backgroundColor: Colors.redAccent,
                        content: 'RA',
                        onPressedIn: () {},
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
