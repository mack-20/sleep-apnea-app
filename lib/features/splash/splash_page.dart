import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    // For now, fake the condition. Later we’ll check Hive.
    final hasProfiles = false; // pretend check

    if (mounted) {
      if (hasProfiles) {
        context.go('/profiles');
      } else {
        context.go('/create-profile');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1B263B),
      body: Center(
        child: Text(
          'Sleep Apnea Monitor',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
