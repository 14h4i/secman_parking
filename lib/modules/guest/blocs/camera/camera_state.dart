part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CameraInitial extends CameraState {}

class TakePictureSuccess extends CameraState {
  final File? file;

  TakePictureSuccess({required this.file});

  @override
  List<Object?> get props => [file];
}

class CameraInitialized extends CameraState {
  final CameraController? controller;

  CameraInitialized({required this.controller});

  @override
  List<Object?> get props => [controller];
}

class CameraFailure extends CameraState {
  final Object? error;

  CameraFailure({this.error});

  @override
  List<Object?> get props => [error];
}
