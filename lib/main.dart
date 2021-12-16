import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/providers/firebase_initializer.dart';
import 'package:secman_parking/providers/log_provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

List<CameraDescription> cameras = [];
LogProvider get logger => const LogProvider('⚡️ MainApp');

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    logger.log('Availabled Cameras');
  } on CameraException catch (e) {
    logger.log('Error in fetching the cameras: $e');
  }
  runApp(
    FirebaseInitializer(
      child: MyApp(settingsController: settingsController),
    ),
  );
}
