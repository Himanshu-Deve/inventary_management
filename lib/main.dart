import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management/network/internet_bloc.dart';
import 'package:inventory_management/config/session_manager.dart';
import 'package:inventory_management/navigator/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InternetBloc()..add(InternetObserveEvent()),
      child: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          // 🔥 No Internet → Show offline screen
          if (!state.isConnected) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: NoInternetScreen(),
            );
          }

          // 🔥 Internet Available → Show app
          return MaterialApp.router(
            routerConfig: AppRoutes.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.wifi_off, size: 80, color: Colors.red),
            SizedBox(height: 16),
            Text("No Internet Connection",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Please check your network settings.",
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
