import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/main.dart';
import 'package:secman_parking/modules/scan/blocs/scan_bloc.dart';
import 'package:secman_parking/providers/bloc_provider.dart';
import 'package:secman_parking/providers/log_provider.dart';
import 'package:secman_parking/themes/app_themes.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  LogProvider get logger => const LogProvider('⚡️ Camera');
  ScanBloc? get bloc => BlocProvider.of<ScanBloc>(context);
  CameraController? controller;

  // File? _imageFile;

  // Initial values
  bool _isCameraInitialized = false;
  int _index = 0;

  // Current values
  // FlashMode? _currentFlashMode;

  List<File> allFileList = [];

  @override
  void initState() {
    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
    super.didChangeAppLifecycleState(state);
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
                bloc!.takePicture(controller!);
              },
              //  {
              //   XFile? rawImage = await takePicture();
              //   File imageFile = File(rawImage!.path);

              //   int currentUnix = DateTime.now().millisecondsSinceEpoch;

              //   final directory = await getApplicationDocumentsDirectory();

              //   String fileFormat = imageFile.path.split('.').last;

              //   print(fileFormat);

              //   await imageFile.copy(
              //     '${directory.path}/$currentUnix.$fileFormat',
              //   );

              //   refreshAlreadyCapturedImages();
              // },
              icon: const Icon(Icons.camera_alt))
        ],
      ),
      backgroundColor: _buildBackgroundColor(_index),
      drawer: const AppDrawer(),
      body: _isCameraInitialized
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Builder(builder: (context) {
                if (_index == 1) {
                  return const InfoCard(
                    isIn: true,
                    isGuest: false,
                  );
                }
                if (_index == 2) {
                  return StreamBuilder<File?>(
                    stream: bloc!.lastImageCameraStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const InfoCard(
                          isIn: false,
                          isGuest: true,
                          urlImage: 'error',
                        );
                      }
                      if (snapshot.hasData) {
                        final file = snapshot.data;
                        return InfoCard(
                          isIn: false,
                          isGuest: true,
                          urlImage: file?.path,
                        );
                      }
                      return const InfoCard(
                        isIn: false,
                        isGuest: true,
                        // urlImage: _imageFile != null ? _imageFile!.path : null,
                      );
                    },
                  );
                }
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
            )
          : const Center(
              child: AutoSizeText(
                'Đang khởi động máy ảnh',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 100,
                ),
              ),
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

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
      await cameraController.setFlashMode(FlashMode.auto);
    } on CameraException catch (e) {
      logger.log('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  // Future<XFile?> takePicture() async {
  //   final CameraController? cameraController = controller;
  //   if (cameraController!.value.isTakingPicture) {
  //     // A capture is already pending, do nothing.
  //     return null;
  //   }
  //   try {
  //     XFile file = await cameraController.takePicture();
  //     return file;
  //   } on CameraException catch (e) {
  //     logger.log('Error occured while taking picture: $e');
  //     return null;
  //   }
  // }

  // refreshAlreadyCapturedImages() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   List<FileSystemEntity> fileList = await directory.list().toList();
  //   allFileList.clear();
  //   List<Map<int, dynamic>> fileNames = [];

  //   for (var file in fileList) {
  //     if (file.path.contains('.jpg')) {
  //       allFileList.add(File(file.path));

  //       String name = file.path.split('/').last.split('.').first;
  //       fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
  //     }
  //   }

  //   if (fileNames.isNotEmpty) {
  //     final recentFile =
  //         fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
  //     String recentFileName = recentFile[1];
  //     if (recentFileName.contains('.jpg')) {
  //       _imageFile = File('${directory.path}/$recentFileName');
  //     }
  //     setState(() {});
  //   }
  // }
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
