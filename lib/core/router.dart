import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:sleep_apnea_app/features/home/presentation/home_page.dart';
import 'package:sleep_apnea_app/features/profiles/data/profile_model.dart';
import 'package:sleep_apnea_app/features/profiles/presentation/select_profile_page.dart';

import '../features/splash/splash_page.dart';
import '../features/profiles/presentation/select_profile_page.dart';
import '../features/profiles/presentation/create_profile_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/profiles',
        builder: (context, state) => const SelectProfilePage(),
      ),
      GoRoute(
        path: '/create-profile',
        builder: (context, state) => const CreateProfilePage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          final profile = state.extra as ProfileModel;
          return HomePage(profile: profile);
        }
      )
    ],
  );
}
