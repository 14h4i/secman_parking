part of 'guest_bloc.dart';

abstract class GuestEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TakePictureEvent extends GuestEvent {}

class OnNewCameraEvent extends GuestEvent {
  final CameraDescription cameraDescription;

  OnNewCameraEvent({required this.cameraDescription});

  @override
  List<Object?> get props => [cameraDescription];
}

class ChangeAppLifecycleStateEvent extends GuestEvent {
  final AppLifecycleState appLifecycleState;

  ChangeAppLifecycleStateEvent({required this.appLifecycleState});

  @override
  List<Object?> get props => [appLifecycleState];
}
