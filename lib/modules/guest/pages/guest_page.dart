import 'dart:io';

// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
// import 'package:secman_parking/main.dart';
import 'package:secman_parking/modules/guest/blocs/guest_bloc.dart';
import 'package:secman_parking/themes/app_themes.dart';
import 'package:auto_size_text/auto_size_text.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({Key? key}) : super(key: key);

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> with WidgetsBindingObserver {
  GuestBloc? get bloc => BlocProvider.of<GuestBloc>(context);
  // CameraController? controller;

  // File? _imageFile;

  // Initial values
  // bool _isCameraInitialized = false;
  int _index = 0;

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
    bloc!.add(
        ChangeAppLifecycleStateEvent(appLifecycleState: appLifecycleState));

    super.didChangeAppLifecycleState(appLifecycleState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _buildBackgroundColor(_index),
        iconTheme: AppThemes.iconThemeAppBar,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _onTap,
            icon: const Icon(Icons.ac_unit),
          ),
          IconButton(
              onPressed: () async {
                bloc!.add(TakePictureEvent());
              },
              icon: const Icon(Icons.camera_alt))
        ],
      ),
      backgroundColor: _buildBackgroundColor(_index),
      drawer: const AppDrawer(),
      body: BlocBuilder<GuestBloc, GuestState>(
        builder: (context, state) {
          if (state is InitialGuestState) {
            return const Center(
              child: AutoSizeText(
                'Đang Khởi động máy ảnh...',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 100,
                ),
              ),
            );
          }
          if (state is CameraInitializedFailureState) {
            return Center(
              child: AutoSizeText(
                'Khởi động máy ảnh thất bại.\n Error: ${state.error}',
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 100,
                ),
              ),
            );
          }
          if (state is CameraInitializedState) {
            return Center(
              child: AutoSizeText(
                'Khởi động máy ảnh: ${state.isCameraInitialized}',
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 100,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Builder(builder: (context) {
              if (_index == 1) {
                return const InfoCard(
                  isIn: true,
                  isGuest: false,
                );
              }
              if (_index == 2) {
                // return BlocBuilder<GuestBloc, GuestState>(
                //   builder: (context, state) {
                if (state is TakePictureFailureState) {
                  return InfoCard(
                    isIn: false,
                    isGuest: true,
                    urlImage: '${state.error}',
                  );
                }
                if (state is TakePictureSuccessState) {
                  final file = state.file!;
                  return InfoCard(
                    isIn: false,
                    isGuest: true,
                    urlImage: file.path,
                  );
                }
                return const InfoCard(
                  isIn: false,
                  isGuest: true,
                  // urlImage: _imageFile != null ? _imageFile!.path : null,
                );
              }

              //   );
              // }
              return const Center(
                child: AutoSizeText(
                  'Quét mã...',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Color _buildBackgroundColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.redAccent;
    }
    return Colors.blue;
  }

  void _onTap() {
    if (_index == 2) {
      setState(() {
        _index = 0;
      });
    } else {
      setState(() {
        _index++;
      });
    }
  }
}

class InfoCard extends StatelessWidget {
  final bool isIn;
  final bool isGuest;
  final String? urlImage;

  const InfoCard({
    Key? key,
    required this.isIn,
    required this.isGuest,
    this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: isGuest
                ? urlImage != null
                    ? Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(urlImage!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    // CachedNetworkImage(
                    //     imageUrl: urlImage!,
                    //     progressIndicatorBuilder:
                    //         (context, url, downloadProgress) =>
                    //             CircularProgressIndicator(
                    //                 value: downloadProgress.progress),
                    //     errorWidget: (context, url, error) => Container(
                    //       padding: const EdgeInsets.all(8.0),
                    //       decoration: BoxDecoration(
                    //           border:
                    //               Border.all(width: 3, color: Colors.white)),
                    //       child: const AutoSizeText(
                    //         'Không tải được ảnh',
                    //         maxLines: 1,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 30,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   )
                    : Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.white)),
                        child: const AutoSizeText(
                          'Không tìm thấy ảnh',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                : const AutoSizeText(
                    '123.45',
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 100,
                    ),
                  ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AutoSizeText(
                'Mã thẻ ...........',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                ),
              ),
              AutoSizeText(
                isGuest ? 'Khách vãng lai' : 'Người tòa nhà',
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const AutoSizeText(
                '20:30 14/12/2021',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 40),
              Icon(
                isIn ? Icons.arrow_downward : Icons.arrow_upward,
                size: 150,
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    );
  }
}
