import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/router.dart';

class SleepApneaApp extends StatelessWidget {
  const SleepApneaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;
    return MaterialApp.router(
      title: 'Sleep Apnea Monitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: router,
    );
  }
}
