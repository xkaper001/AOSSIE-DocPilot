import 'package:docpilot_core/docpilot_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'gen/assets.gen.dart';

class MainFrame extends StatefulWidget {
  const MainFrame({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainFrame> createState() => _MainFrameState();
}

class _MainFrameState extends State<MainFrame> {
  void _onTabChanged(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  int get _currentIndex => widget.navigationShell.currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: CoreBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabChanged,
        destinations: [
          NavigationDestination(
            icon: Assets.icons.patients.svg(),
            selectedIcon: Assets.icons.patientsSelected.svg(),
            label: 'Patients',
          ),
          NavigationDestination(
            icon: Assets.icons.home.svg(),
            selectedIcon: Assets.icons.homeSelected.svg(),
            label: 'Dash',
          ),
          NavigationDestination(
            icon: Assets.icons.calendar.svg(),
            selectedIcon: Assets.icons.calendarSelected.svg(),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Assets.icons.prescribe.svg(),
            label: 'Prescribe',
            selectedIcon: Assets.icons.prescribeSelected.svg(),
          ),
        ],
      ),
      body: widget.navigationShell,
    );
  }
}
