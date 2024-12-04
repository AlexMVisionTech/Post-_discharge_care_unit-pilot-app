


import 'package:get/get.dart';
import 'package:post_discharge/Screens/Create%20Account/create_account.dart';
import 'package:post_discharge/Screens/authentication/LoginScreen/login.dart';

var transmition =Transition.fadeIn;
var routes=[
  GetPage(name: "/", page: ()=>const LoginScreen(),transition: transmition),
  GetPage(name:"/CreateAccount", page: ()=>const CreateAccount(),transition: transmition)
];