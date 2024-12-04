import 'package:flutter/material.dart';

Widget myTextField({required TextEditingController controller, String hint='',IconData icon=Icons.abc,bool isPassword=false,}){
   return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      border: const OutlineInputBorder(),
      prefixIcon: Icon(icon),
      suffixIcon: isPassword? const Icon(Icons.visibility):null,
    ),
   ) ;
}
