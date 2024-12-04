import 'package:flutter/material.dart';
import 'package:post_discharge/Screens/authentication/LoginScreen/login.dart';
import 'package:post_discharge/util/Constants/theme.dart';
import 'package:get/get.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme:MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}