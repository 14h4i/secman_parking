import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/blocs/app_bloc.dart';
import 'package:secman_parking/modules/guest/blocs/camera/camera_bloc.dart';
import 'package:secman_parking/modules/manager/blocs/manager_bloc.dart';
import 'package:secman_parking/route/route_name.dart';
import 'package:secman_parking/route/routes.dart';
import 'package:secman_parking/src/settings/settings_controller.dart';

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appStateBloc = AppBloc();
  static final GlobalKey<State> key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc()..add(LaunchAppEvent()),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.status == AppStatus.loading) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Container(
                color: Colors.white,
              ),
            );
          }
          if (state.status == AppStatus.unAuthorized) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              key: const ValueKey('UnAuthorized'),
              initialRoute: RouteName.welcomePage,
              builder: _builder,
              onGenerateRoute: Routes.unAuthorizedRoute,
            );
          }

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CameraBloc(),
              ),
              BlocProvider(
                create: (context) => ManagerBloc(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              key: key,
              initialRoute: RouteName.dashboardPage,
              navigatorKey: MyApp.navigatorKey,
              builder: _builder,
              onGenerateRoute: Routes.authorizedRoute,
            ),
          );
        },
      ),
    );
  }

  Widget _builder(BuildContext context, Widget? child) {
    final data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1),
      child: child!,
    );
  }
}
