import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The route configuration for the DocPilot Doctor app.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  errorBuilder: (context, state) => const ErrorScreen(),
);

/// Home screen for DocPilot Doctor
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DocPilot Doctor'),
      ),
      body: const Center(
        child: Text('Welcome to DocPilot Doctor!'),
      ),
    );
  }
}

/// Error screen for handling navigation errors
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('Page not found'),
      ),
    );
  }
}
