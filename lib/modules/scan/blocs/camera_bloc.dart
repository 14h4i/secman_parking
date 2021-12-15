import 'dart:io';

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:secman_parking/providers/bloc_provider.dart';
import 'package:secman_parking/providers/log_provider.dart';

class CameraBloc extends BlocBase {
  LogProvider get logger => const LogProvider('⚡️ CameraBloc');

  final _lastImageCameraCtrl = BehaviorSubject<File?>();
  Stream<File?> get lastImageCameraStream => _lastImageCameraCtrl.stream;

  Future<void> takePicture(CameraController controller) async {
    XFile? rawImage = await _takePicture(controller);
    File imageFile = File(rawImage!.path);

    int currentUnix = DateTime.now().millisecondsSinceEpoch;

    final directory = await getApplicationDocumentsDirectory();

    String fileFormat = imageFile.path.split('.').last;

    logger.log(fileFormat);

    await imageFile.copy(
      '${directory.path}/$currentUnix.$fileFormat',
    );

    _refreshAlreadyCapturedImages();
  }

  Future<XFile?> _takePicture(CameraController controller) async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      logger.log('Error occured while taking picture: $e');
      return null;
    }
  }

  _refreshAlreadyCapturedImages() async {
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
        _lastImageCameraCtrl.sink
            .add(File('${directory.path}/$recentFileName'));
      }
      // setState(() {});
    }
  }

  @override
  void dispose() {
    _lastImageCameraCtrl.close();
  }
}
