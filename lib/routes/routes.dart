import 'package:booking_app/features/dashboard/dashboard_view.dart';
import 'package:booking_app/widgets/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: [
    TypedStatefulShellBranch<DashboardViewBranchData>(
        routes: [
          TypedGoRoute<DashboardViewRoute>(
              path: '/dashboard',
              name: 'dashboard',
              routes: []
          )
        ]
    )
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  static const String $restorationScopeId = 'appShellRouteDataRestorationScopeId';

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return AppShell(state: state, navigationShell: navigationShell);
  }

}

class DashboardViewBranchData extends StatefulShellBranchData {
  const DashboardViewBranchData();

  static const String $restorationScopeId = 'dashboardViewRestorationScopeId';
}

class DashboardViewRoute extends GoRouteData with $DashboardViewRoute {
  const DashboardViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DashboardView();
  }
}