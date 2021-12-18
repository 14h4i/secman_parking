part of 'guest_bloc.dart';

abstract class GuestState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialGuestState extends GuestState {}

class TakePictureSuccessState extends GuestState {
  final File? file;

  TakePictureSuccessState({required this.file});

  @override
  List<Object?> get props => [file];
}

class TakePictureFailureState extends GuestState {
  final Object? error;

  TakePictureFailureState({this.error});

  @override
  List<Object?> get props => [error];
}

class CameraInitializedState extends GuestState {
  final bool isCameraInitialized;

  CameraInitializedState({required this.isCameraInitialized});

  @override
  List<Object?> get props => [isCameraInitialized];
}

class CameraInitializedFailureState extends GuestState {
  final Object? error;

  CameraInitializedFailureState({this.error});

  @override
  List<Object?> get props => [error];
}
