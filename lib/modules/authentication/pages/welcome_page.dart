import 'package:flutter/material.dart';
import 'package:secman_parking/blocs/app_state_bloc.dart';
import 'package:secman_parking/providers/bloc_provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  AppStateBloc? get appStateBloc => BlocProvider.of<AppStateBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Login'),
          onPressed: _changeAppState,
        ),
      ),
    );
  }

  void _changeAppState() {
    appStateBloc!.changeAppState(AppState.authorized);
  }
}
