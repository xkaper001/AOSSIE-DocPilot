import 'package:flutter/material.dart';

class CoreBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavigationDestination> destinations;

  const CoreBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onTap,
      selectedIndex: currentIndex,
      destinations: destinations,
    );
  }
}
