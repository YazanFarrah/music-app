import 'package:client/core/router/route_paths.dart';
import 'package:client/core/services/user_state.dart';
import 'package:client/core/widgets/nav_bar.dart';
import 'package:client/features/auth/view/pages/auth_page.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: RoutePaths.userState,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: UserState(),
          );
        },
      ),
      GoRoute(
        path: '/auth',
        name: RoutePaths.auth,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: AuthPage(),
          );
        },
      ),
      GoRoute(
        path: '/signup',
        name: RoutePaths.signup,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SignupPage(),
          );
        },
      ),
      GoRoute(
        path: '/login',
        name: RoutePaths.login,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginPage(),
          );
        },
      ),
      GoRoute(
        path: '/nav',
        name: RoutePaths.navScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: NavBar(),
          );
        },
      ),
    ],
  );
}
