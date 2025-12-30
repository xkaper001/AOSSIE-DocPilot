import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'DocPilot Doctor',
      routerConfig: appRouter,
      theme: AppTheme.lightTheme,
    );
  }
}
