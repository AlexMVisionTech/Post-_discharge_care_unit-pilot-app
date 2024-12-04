import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key,required this.buttonText,required this.targetScreen});
  final String buttonText;
  final Widget targetScreen;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () { Get.to(()=>targetScreen); }, child: Text(buttonText),

    );
  }
}