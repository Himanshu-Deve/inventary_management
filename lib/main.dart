
import 'package:flutter/material.dart';
import 'package:inventory_management/config/session_manager.dart';
import 'package:inventory_management/navigator/app_routes.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SessionManager before runApp
  await SessionManager.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      title: 'Issuer App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
