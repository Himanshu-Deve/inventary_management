import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management/config/constant.dart';
import 'package:inventory_management/navigator/my_routes.dart';
import 'package:inventory_management/navigator/splash_screen.dart';
import 'package:inventory_management/screens/homeScreen/ui/home_screen.dart';
import 'package:inventory_management/screens/inScreen/bloc/machine_in_bloc.dart';
import 'package:inventory_management/screens/inScreen/ui/machine_in_screen.dart';
import 'package:inventory_management/screens/loginScreen/bloc/login_screen_bloc.dart';
import 'package:inventory_management/screens/loginScreen/ui/login_screen.dart';
import 'package:inventory_management/screens/outScreen/bloc/machine_out_bloc.dart';
import 'package:inventory_management/screens/outScreen/ui/machine_out_screen.dart';
import 'package:inventory_management/widgets/mobil_scanner_screen.dart';

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
        builder: (context, state) =>
            BlocProvider(
              create: (context) => LoginScreenBloc(),
              child: LoginScreen(),
            ),
      ),
      GoRoute(
        path: MyRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: MyRoutes.inScreen,
        builder: (context, state) =>
            BlocProvider(
              create: (context) => MachineInBloc(),
              child: MachineInScreen(),
            ),
      ),
      GoRoute(
        path:  MyRoutes.scannerScreen,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;

            return data['isMachineIn']? MachineScannerScreen(
              isMachineIn: data['isMachineIn'] as bool,
              bloc: data["bloc"] as MachineInBloc,
              isNew: data["isNew"] as bool,
              selectProduct: data['selectId'] as int,
            ):MachineScannerScreen(
              isMachineIn: data['isMachineIn'] as bool,
              bloc: data["bloc"] as MachineOutBloc,
              isNew: data["isNew"] as bool,
              userId: data['user_id'] as int,
              number: data['number'] as String,
            );
          }),
      GoRoute(
        path: MyRoutes.scanListingScreen,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return ScanListingScreen(
            list: data["list"] as List<String>,
            onRemove: data["onRemove"] as Function(String),
            selectId: data['selectId'],
          );
        },
      ),
      GoRoute(
        path: MyRoutes.outScreen,
        builder: (context, state) =>
            BlocProvider(
              create: (context) => MachineOutBloc(),
              child: MachineOutScreen(),
            ),
      ),

    ],
  );
}
