import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management/config/constant.dart';
import 'package:inventory_management/navigator/my_routes.dart';
import 'package:inventory_management/navigator/splash_screen.dart';
import 'package:inventory_management/screens/homeScreen/ui/home_screen.dart';
import 'package:inventory_management/screens/loginScreen/bloc/login_screen_bloc.dart';
import 'package:inventory_management/screens/loginScreen/ui/login_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    navigatorKey: AppGlobals.navigatorKey,
    initialLocation: MyRoutes.splashScreen,
    routes: [
      GoRoute(
        path: MyRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: MyRoutes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginScreenBloc(),
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: MyRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),

    ],
  );
}
