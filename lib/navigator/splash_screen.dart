import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management/config/session_manager.dart';
import 'package:inventory_management/navigator/my_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLoggedIn();
  }

  Future<void> isLoggedIn()async{
    bool loggedIn = await SessionManager.instance.isLoggedIn();
    Future.delayed(const Duration(seconds: 2), () {
      print(loggedIn);
      if(loggedIn){
        context.go(MyRoutes.home);
      }else{
        context.go(MyRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/homeAssets/apnibus-logo.png")
          ],
        ),
      ),
    );
  }
}