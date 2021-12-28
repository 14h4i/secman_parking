part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TakePicture extends CameraEvent {}

class NewCamera extends CameraEvent {
  final CameraDescription cameraDescription;

  NewCamera({required this.cameraDescription});

  @override
  List<Object?> get props => [cameraDescription];
}

class ChangeAppLifecycle extends CameraEvent {
  final AppLifecycleState appLifecycleState;

  ChangeAppLifecycle({required this.appLifecycleState});

  @override
  List<Object?> get props => [appLifecycleState];
}

class ResetCamera extends CameraEvent {}
