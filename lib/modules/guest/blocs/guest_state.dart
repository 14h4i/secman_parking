part of 'guest_bloc.dart';

abstract class GuestState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GuestInitial extends GuestState {}

class GuestTakePictureSuccess extends GuestState {
  final File? file;

  GuestTakePictureSuccess({required this.file});

  @override
  List<Object?> get props => [file];
}

class GuestTakePictureFailure extends GuestState {
  final Object? error;

  GuestTakePictureFailure({this.error});

  @override
  List<Object?> get props => [error];
}

class GuestCameraInitialized extends GuestState {
  final bool isCameraInitialized;

  GuestCameraInitialized({required this.isCameraInitialized});

  @override
  List<Object?> get props => [isCameraInitialized];
}

class GuestCameraInitializedFailure extends GuestState {
  final Object? error;

  GuestCameraInitializedFailure({this.error});

  @override
  List<Object?> get props => [error];
}
