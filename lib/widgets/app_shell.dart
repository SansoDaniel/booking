import 'package:booking_app/routes/routes.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.state,
    required this.navigationShell,
    super.key,
  });

  final GoRouterState state;
  final StatefulNavigationShell navigationShell;

  void _onTap(BuildContext context, int index) {
    DashboardViewRoute().go(context);
    // switch (index) {
    //   case 0:
    //     DashboardViewRoute().go(context);
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: .fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Dashboard',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (value) => _onTap(context, value),
      ),
    );
  }
}
