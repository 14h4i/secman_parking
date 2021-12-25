import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/modules/guest/blocs/camera/camera_bloc.dart';
import 'package:secman_parking/modules/internal/widgets/button_in_out.dart';
import 'package:secman_parking/modules/internal/widgets/time_in_out.dart';
import 'package:secman_parking/themes/app_text_style.dart';
import 'package:secman_parking/themes/app_themes.dart';
import 'package:auto_size_text/auto_size_text.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({Key? key}) : super(key: key);

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> with WidgetsBindingObserver {
  CameraBloc? get bloc => BlocProvider.of<CameraBloc>(context);
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
    super.initState();
  }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    bloc!.add(ChangeAppLifecycle(appLifecycleState: appLifecycleState));

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
                bloc!.add(TakePicture());
              },
              icon: const Icon(Icons.camera_alt))
        ],
      ),
      backgroundColor: _backgroudColor,
      drawer: const AppDrawer(),
      body: BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) {
          if (state is CameraFailure) {
            return Center(
              child: AutoSizeText(
                'Error: ${state.error}',
                maxLines: 1,
                style: AppTextStyle.largeTitleCard,
              ),
            );
          }
          if (state is CameraInitialized) {
            if (state.controller!.value.isInitialized) {
              return CameraPreview(
                state.controller!,
                // child: LayoutBuilder(builder:
                //     (BuildContext context, BoxConstraints constraints) {
                //   return GestureDetector(
                //     behavior: HitTestBehavior.opaque,
                //     onScaleStart: _handleScaleStart,
                //     onScaleUpdate: _handleScaleUpdate,
                //     onTapDown: (details) =>
                //         onViewFinderTap(details, constraints),
                //   );
                // }),
              );
            } else {
              return const Center(
                child: AutoSizeText(
                  'Không thể khởi động máy ảnh',
                  maxLines: 1,
                  style: AppTextStyle.largeTitleCard,
                ),
              );
            }
          }

          if (state is TakePictureSuccess) {
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: state.file != null
                      ? Image.file(state.file!)
                      : Container(),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ButtonInOut(
                      onPressedIn: () {},
                      onPressedOut: () {},
                    ),
                    // child: Padding(
                    //   padding: const EdgeInsets.only(top: 80),
                    //   child: TimeInOut(
                    //     isIn: true,
                    //     timeIn: DateTime.now(),
                    //     timeOut: DateTime.now(),
                    //   ),
                    // ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
