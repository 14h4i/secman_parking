import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:secman_parking/providers/log_provider.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  LogProvider get logger => const LogProvider('⚡️ GuestBloc');

  CameraController? controller;

  CameraBloc() : super(CameraInitial()) {
    on<TakePicture>(_onTakePicture);
    on<NewCamera>(_onNewCamera);
    on<ChangeAppLifecycle>(_onChangeAppLifecycle);
  }

  void _onChangeAppLifecycle(CameraEvent event, Emitter<CameraState> emit) {
    if (event is ChangeAppLifecycle) {
      final CameraController? cameraController = controller;

      // App state changed before we got the chance to initialize.
      if (cameraController == null || !cameraController.value.isInitialized) {
        return;
      }

      if (event.appLifecycleState == AppLifecycleState.inactive) {
        // Free up memory when camera not active
        cameraController.dispose();
      } else if (event.appLifecycleState == AppLifecycleState.resumed) {
        // Reinitialize the camera with same properties
        _onNewCamera(
            NewCamera(cameraDescription: cameraController.description), emit);
      }
    }
  }

  void _onNewCamera(CameraEvent event, Emitter<CameraState> emit) async {
    if (event is NewCamera) {
      final previousCameraController = controller;
      // Instantiating the camera controller
      final CameraController cameraController = CameraController(
        event.cameraDescription,
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      // Dispose the previous controller
      await previousCameraController?.dispose();

      // Replace with the new controller

      controller = cameraController;

      // Update UI if controller updated
      // cameraController.addListener(() {
      //   if (mounted) setState(() {});
      // });

      // Initialize controller
      try {
        await cameraController.initialize();
        await cameraController.setFlashMode(FlashMode.auto);
        emit(CameraInitialized(controller: controller));
      } on CameraException catch (e) {
        emit(CameraFailure(error: e));
        logger.log('Error initializing camera: $e');
      }

      // Update the Boolean
      // if (mounted) {
      //   setState(() {

      // _isCameraInitialized = controller!.value.isInitialized;
      //   });
      // }
    }
  }

  Future<void> _onTakePicture(
      CameraEvent event, Emitter<CameraState> emit) async {
    if (event is TakePicture) {
      XFile? rawImage = await _takePicture(emit);
      File imageFile = File(rawImage!.path);

      emit(TakePictureSuccess(file: imageFile));

      // int currentUnix = DateTime.now().millisecondsSinceEpoch;

      // final directory = await getApplicationDocumentsDirectory();

      // String fileFormat = imageFile.path.split('.').last;

      // logger.log(fileFormat);

      // await imageFile.copy(
      //   '${directory.path}/$currentUnix.$fileFormat',
      // );

      // await _refreshAlreadyCapturedImages(emit);
    }
  }

  Future<XFile?> _takePicture(Emitter<CameraState> emit) async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      emit(CameraFailure(error: e));
      logger.log('Error occured while taking picture: $e');
      return null;
    }
  }

  // Future<void> _refreshAlreadyCapturedImages(Emitter<CameraState> emit) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   List<FileSystemEntity> fileList = await directory.list().toList();
  //   List<File> allFileList = [];
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
  //       emit(TakePictureSuccess(
  //           file: File('${directory.path}/$recentFileName')));
  //     }
  //     // setState(() {});
  //   }
  // }

  @override
  Future<void> close() {
    controller!.dispose();
    return super.close();
  }
}
