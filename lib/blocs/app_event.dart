part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LaunchAppEvent extends AppEvent {}

class ChangeAppStateEvent extends AppEvent {
  final AppState state;

  ChangeAppStateEvent({required this.state});

  @override
  List<Object?> get props => [state];
}

class LogoutEvent extends AppEvent {}
