// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$appShellRouteData];

RouteBase get $appShellRouteData => StatefulShellRouteData.$route(
  restorationScopeId: AppShellRouteData.$restorationScopeId,
  factory: $AppShellRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      restorationScopeId: DashboardViewBranchData.$restorationScopeId,
      routes: [
        GoRouteData.$route(
          path: '/dashboard',
          name: 'dashboard',
          factory: $DashboardViewRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $AppShellRouteDataExtension on AppShellRouteData {
  static AppShellRouteData _fromState(GoRouterState state) =>
      const AppShellRouteData();
}

mixin $DashboardViewRoute on GoRouteData {
  static DashboardViewRoute _fromState(GoRouterState state) =>
      const DashboardViewRoute();

  @override
  String get location => GoRouteData.$location('/dashboard');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
