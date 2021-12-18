import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secman_parking/providers/log_provider.dart';

part 'guest_event.dart';
part 'guest_state.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  LogProvider get logger => const LogProvider('⚡️ GuestBloc');

  CameraController? controller;

  GuestBloc() : super(InitialGuestState()) {
    on<TakePictureEvent>(takePicture);
    on<OnNewCameraEvent>(onNewCameraSelected);
    on<ChangeAppLifecycleStateEvent>(didChangeAppLifecycleState);
  }

  void didChangeAppLifecycleState(GuestEvent event, Emitter<GuestState> emit) {
    if (event is ChangeAppLifecycleStateEvent) {
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
        onNewCameraSelected(
            OnNewCameraEvent(cameraDescription: cameraController.description),
            emit);
      }
    }
  }

  void onNewCameraSelected(GuestEvent event, Emitter<GuestState> emit) async {
    if (event is OnNewCameraEvent) {
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
      } on CameraException catch (e) {
        emit(CameraInitializedFailureState(error: e));
        logger.log('Error initializing camera: $e');
      }

      // Update the Boolean
      // if (mounted) {
      //   setState(() {
      emit(CameraInitializedState(
          isCameraInitialized: controller!.value.isInitialized));
      // _isCameraInitialized = controller!.value.isInitialized;
      //   });
      // }
    }
  }

  Future<void> takePicture(GuestEvent event, Emitter<GuestState> emit) async {
    if (event is TakePictureEvent) {
      XFile? rawImage = await _takePicture(emit);
      File imageFile = File(rawImage!.path);

      int currentUnix = DateTime.now().millisecondsSinceEpoch;

      final directory = await getApplicationDocumentsDirectory();

      String fileFormat = imageFile.path.split('.').last;

      logger.log(fileFormat);

      await imageFile.copy(
        '${directory.path}/$currentUnix.$fileFormat',
      );

      await _refreshAlreadyCapturedImages(emit);
    }
  }

  Future<XFile?> _takePicture(Emitter<GuestState> emit) async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      emit(TakePictureFailureState(error: e));
      logger.log('Error occured while taking picture: $e');
      return null;
    }
  }

  Future<void> _refreshAlreadyCapturedImages(Emitter<GuestState> emit) async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    List<File> allFileList = [];
    List<Map<int, dynamic>> fileNames = [];

    for (var file in fileList) {
      if (file.path.contains('.jpg')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    }

    if (fileNames.isNotEmpty) {
      final recentFile =
          fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      String recentFileName = recentFile[1];
      if (recentFileName.contains('.jpg')) {
        // final fil =  File('${directory.path}/$recentFileName');

        emit(TakePictureSuccessState(
            file: File('${directory.path}/$recentFileName')));
        // _lastImageCameraCtrl.sink
        //     .add(File('${directory.path}/$recentFileName'));
      }
      // setState(() {});
    }
  }
}
