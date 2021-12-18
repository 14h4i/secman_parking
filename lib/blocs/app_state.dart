part of 'app_bloc.dart';

enum AppStatus { loading, unAuthorized, authorized }

abstract class AppState extends Equatable {
  final AppStatus status;

  const AppState({required this.status});

  @override
  List<Object?> get props => [status];
}

class LoadingAppState extends AppState {
  const LoadingAppState() : super(status: AppStatus.loading);

  // final AppStatus status;
  // LoadingAppState({this.status = AppStatus.loading});

  @override
  List<Object?> get props => [status];
}

class UnAuthorizedAppState extends AppState {
  const UnAuthorizedAppState() : super(status: AppStatus.unAuthorized);

  @override
  List<Object?> get props => [status];
}

class AuthorizedAppState extends AppState {
  const AuthorizedAppState() : super(status: AppStatus.authorized);

  @override
  List<Object?> get props => [status];
}
