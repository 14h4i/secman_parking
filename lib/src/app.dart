import 'package:flutter/material.dart';
import 'package:secman_parking/blocs/app_state_bloc.dart';
import 'package:secman_parking/providers/bloc_provider.dart';
import 'package:secman_parking/route/routes.dart';
import 'package:secman_parking/src/settings/settings_controller.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appStateBloc = AppStateBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: appStateBloc,
      child: StreamBuilder<AppState>(
          stream: appStateBloc.appState,
          initialData: appStateBloc.initState,
          builder: (context, snapshot) {
            if (snapshot.data == AppState.loading) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Container(
                  color: Colors.white,
                ),
              );
            }
            if (snapshot.data == AppState.unAuthorized) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.light,
                builder: _builder,
                onGenerateRoute: Routes.unAuthorizedRoute,
              );
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              builder: _builder,
              onGenerateRoute: Routes.authorizedRoute,
            );
          }),
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
