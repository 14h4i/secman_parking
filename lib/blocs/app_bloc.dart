import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/utils/prefs_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const LoadingAppState()) {
    on<LaunchAppEvent>((event, emit) => _launchApp(emit));
    on<ChangeAppStateEvent>(_changeAppState);
    on<LogoutEvent>((event, emit) => _logout(emit));
  }

  Future<void> _launchApp(Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final authorLevel = prefs.getInt(PrefsKey.authorLevel) ?? 0;
    // logger.log('authorLevel $authorLevel');
    //langCode = prefs.getString('langCode') ?? 'vi';

    switch (authorLevel) {
      case 2:
        await _changeAppState(
            ChangeAppStateEvent(state: const AuthorizedAppState()), emit);
        break;
      default:
        await _changeAppState(
            ChangeAppStateEvent(state: const UnAuthorizedAppState()), emit);
    }
  }

  Future<void> _changeAppState(AppEvent event, Emitter<AppState> emit) async {
    if (event is ChangeAppStateEvent) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(PrefsKey.authorLevel, event.state.status.index);
      emit(event.state);
    }
  }

  Future<void> _logout(Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    await _changeAppState(
        ChangeAppStateEvent(state: const UnAuthorizedAppState()), emit);
  }
}

  

// class AppBloc implements BlocBase {
//   final _appState = BehaviorSubject<AppStatus>.seeded(AppStatus.loading);

//   Stream<AppStatus> get appState => _appState.stream;

//   AppStatus get appStateValue => _appState.stream.value;

//   AppStatus get initState => AppStatus.loading;

//   String langCode = 'en';

//   LogProvider get logger => const LogProvider('⚡️ AppStateBloc');

//   AppBloc() {
//     launchApp();
//   }

//   Future<void> launchApp() async {
//     final prefs = await SharedPreferences.getInstance();
//     final authorLevel = prefs.getInt(PrefsKey.authorLevel) ?? 0;
//     logger.log('authorLevel $authorLevel');
//     //langCode = prefs.getString('langCode') ?? 'vi';

//     switch (authorLevel) {
//       case 2:
//         await changeAppState(AppStatus.authorized);
//         break;
//       default:
//         await changeAppState(AppStatus.unAuthorized);
//     }
//   }

//   Future<void> changeAppState(AppStatus state) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(PrefsKey.authorLevel, state.index);
//     logger.log('changeAppState $state');

//     _appState.sink.add(state);
//   }

//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.clear();

//     await changeAppState(AppStatus.unAuthorized);
//   }

//   @override
//   void dispose() {
//     _appState.close();
//   }
// }
