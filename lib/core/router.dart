import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../features/splash/splash_page.dart';
import '../features/profiles/presentation/profile_list_page.dart';
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
        builder: (context, state) => const ProfileListPage(),
      ),
      GoRoute(
        path: '/create-profile',
        builder: (context, state) => const CreateProfilePage(),
      ),
    ],
  );
}
