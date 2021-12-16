import 'dart:io';

import 'package:camera/camera.dart';
import 'package:secman_parking/modules/guest/blocs/camera_bloc.dart';
import 'package:secman_parking/providers/bloc_provider.dart';

class GuestBloc extends BlocBase {
  final CameraBloc _cameraBloc;

  GuestBloc() : _cameraBloc = CameraBloc();

  Stream<File?> get lastImageCameraStream => _cameraBloc.lastImageCameraStream;

  Future<void> takePicture(CameraController controller) async {
    _cameraBloc.takePicture(controller);
  }

  @override
  void dispose() {}
}
