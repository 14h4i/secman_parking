import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/modules/authentication/pages/login_page.dart';
import 'package:secman_parking/modules/authentication/pages/password_page.dart';
import 'package:secman_parking/modules/authentication/pages/pin_code_page.dart';
import 'package:secman_parking/modules/authentication/pages/welcome_page.dart';
import 'package:secman_parking/modules/fee/blocs/fee_bloc.dart';
import 'package:secman_parking/modules/fee/pages/fee_page.dart';
import 'package:secman_parking/modules/manager/blocs/manager_bloc.dart';
import 'package:secman_parking/modules/manager/pages/add_internal_card_page.dart';
import 'package:secman_parking/modules/dashboard/pages/dashboard_page.dart';
import 'package:secman_parking/modules/manager/pages/manager_page.dart';
import 'package:secman_parking/route/route_name.dart';

class Routes {
  static Route authorizedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.dashboardPage:
        return _buildRoute(
          settings,
          const DashboardPage(),
        );

      case RouteName.addInternalCardPage:
        return _buildRoute(
          settings,
          const AddInternalCardPage(),
        );
      case RouteName.feePage:
        return _buildRoute(
          settings,
          BlocProvider(
            create: (_) => FeeBloc()..add(GetListFee()),
            child: const FeePage(),
          ),
        );
      case RouteName.managerPage:
        return _buildRoute(
          settings,
          const ManagerPage(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route unAuthorizedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.welcomePage:
        return _buildRoute(
          settings,
          const WelcomePage(),
        );
      case RouteName.loginPage:
        return _buildRoute(
          settings,
          const LoginPage(),
        );

      case RouteName.pinCodePage:
        return _buildRoute(
          settings,
          const PinCodePage(),
        );
      case RouteName.passwordPage:
        return _buildRoute(
          settings,
          const PasswordPage(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Coming soon'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
