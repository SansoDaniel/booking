import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: [TypedStatefulShellBranch<DashboardViewBranchData>(routes: [])],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  static const String $restorationScopeId =
      'appShellRouteDataRestorationScopeId';
}

class DashboardViewBranchData extends StatefulShellBranchData {
  const DashboardViewBranchData();

  static const String $restorationScopeId = 'dashboardViewRestorationScopeId';
}
