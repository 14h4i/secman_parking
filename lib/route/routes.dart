import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/modules/authentication/pages/welcome_page.dart';
import 'package:secman_parking/modules/manager/blocs/manager_bloc.dart';
import 'package:secman_parking/modules/manager/pages/add_internal_card_page.dart';
import 'package:secman_parking/modules/manager/pages/internal_card_manager_page.dart';
import 'package:secman_parking/modules/dashboard/pages/dashboard_page.dart';
import 'package:secman_parking/route/route_name.dart';

class Routes {
  static Route authorizedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.dashboardPage:
        return _buildRoute(
          settings,
          const DashboardPage(),
        );
      case RouteName.internalCardManagerPage:
        return _buildRoute(
          settings,
          const InternalCardManagerPage(),
        );

      case RouteName.addInternalCardPage:
        return _buildRoute(
          settings,
          const AddInternalCardPage(),
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
