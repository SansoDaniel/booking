import 'package:booking_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            icon: Icon(Icons.location_pin),
            label: 'Explore',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (value) => _onTap(context, value),
      ),
    );
  }
}
