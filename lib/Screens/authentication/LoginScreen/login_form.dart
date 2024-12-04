import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:post_discharge/Screens/Create%20Account/create_account.dart';
import 'package:post_discharge/Screens/dashboard2.dart';
import 'package:post_discharge/util/Constants/sizes.dart';
import 'package:post_discharge/util/Constants/text_string.dart';
import 'package:post_discharge/util/re-usable%20widgets/button.dart';
import 'package:post_discharge/util/re-usable%20widgets/my_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:post_discharge/util/re-usable%20widgets/passwordtextfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MySizes.spacebtwnSections),
        child: Column(
          children: [
            // Email input field
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: MyText.email,
              ),
            ),
            const SizedBox(height: MySizes.spacebtwnItems),
            // Password input field
            PasswordTextfield(
              controller: passwordController,
              hint: 'Enter your password',
            ),
            const SizedBox(height: MySizes.spacebtwnItems),
            // Remember Me and Forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(MyText.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () {}, 
                  child: const Text(MyText.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: MySizes.spacebtwnSections),
            // Sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (emailController.text.isEmpty) {
                    mySnackBar(title: 'Error', message: 'Enter your Email');
                  } else if (passwordController.text.isEmpty) {
                    mySnackBar(title: 'Error', message: 'Enter your Password');
                  } else {
                    // Adjust the request to use GET with query parameters
                    final response = await http.get(
                      Uri.parse("http://localhost/myapis/login.php?email=${emailController.text}&password=${passwordController.text}"),
                    );

                    if (response.statusCode == 200) {
                      final serverData = jsonDecode(response.body);
                      if (serverData['success'] == 1) {
                        // Navigate to the Patient Dashboard
                        Get.to(() => const PatientDashboard());
                      } else {
                        mySnackBar(title: 'Wrong credentials', message: serverData['message']);
                      }
                    } else {
                      mySnackBar(title: 'Server Error', message: 'Error occurred while logging in');
                    }
                  }
                },
                child: const Text(MyText.signIn),
              ),
            ),
            // Create Account button
            const SizedBox(height: MySizes.spacebtwnItems),
            const MyButton(
              buttonText: 'SignUp', 
              targetScreen: CreateAccount(),
            ),
          ],
        ),
      ),
    );
  }
}