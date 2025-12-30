import 'package:docpilot_doctor/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:docpilot_doctor/features/dashboard/presentation/screens/dashboard.dart';
import 'package:docpilot_doctor/features/patient/presentation/screens/patient_screen.dart';
import 'package:docpilot_doctor/features/prescription/presentation/screens/prescribe_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../main_frame.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/dashboard',
  debugLogDiagnostics: true,
  routes: [
    // GoRoute(
    //   path: '/',
    //   name: 'home',
    //   builder: (context, state) => const HomeScreen(),
    // ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainFrame(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/patients',
              builder: (context, state) => PatientScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => Dashboard(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calendar',
              builder: (context, state) => CalendarScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/prescribe',
              builder: (context, state) => PrescribeScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
