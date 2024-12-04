import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_discharge/Screens/authentication/LoginScreen/login.dart';
import 'package:post_discharge/util/Constants/sizes.dart';
import 'package:post_discharge/util/Constants/text_string.dart';
import 'package:post_discharge/util/re-usable widgets/my_snackbar.dart';
import 'package:post_discharge/util/re-usable widgets/passwordtextfield.dart';
import 'package:post_discharge/util/re-usable widgets/textfield.dart';
import 'package:http/http.dart' as http;

TextEditingController firstNameController = TextEditingController();
TextEditingController otherNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();
TextEditingController phoneController = TextEditingController();

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(MyText.createAccountBtn),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Column(
          children: [
            // Title
            Text(
              MyText.signuptitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: MySizes.spacebtwnSections),
            Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: myTextField(
                          controller: firstNameController,
                          hint: "Enter your first name",
                          icon: Icons.person,
                        ),
                      ),
                      const SizedBox(width: MySizes.spacebtwnItems),
                      Expanded(
                        child: myTextField(
                          controller: otherNameController,
                          hint: "Enter your other name",
                          icon: Icons.person,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: MySizes.spacebtwnItems),
                  myTextField(
                    controller: phoneController,
                    hint: "Enter your Phone number",
                    icon: Icons.phone,
                  ),
                  const SizedBox(height: MySizes.spacebtwnItems),
                  myTextField(
                    controller: emailController,
                    hint: "Enter your Email",
                    icon: Icons.email,
                  ),
                  const SizedBox(height: MySizes.spacebtwnItems),
                  PasswordTextfield(
                    hint: 'Enter your password',
                    controller: passwordController,
                  ),
                  const SizedBox(height: MySizes.spacebtwnItems),
                  PasswordTextfield(
                    hint: 'Confirm your password',
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(height: MySizes.spacebtwnSections),
                  ElevatedButton(
                    onPressed: () async {
                      // Validation
                      if (firstNameController.text.isEmpty) {
                        mySnackBar(title: "Validation", message: "Please Enter Your Name");
                      } else if (otherNameController.text.isEmpty) {
                        mySnackBar(title: "Validation", message: "Please Enter your Other Name");
                      } else if (phoneController.text.isEmpty) {
                        mySnackBar(title: "Validation", message: "Please Enter Your Phone Number");
                      } else if (emailController.text.isEmpty) {
                        mySnackBar(title: "Validation", message: "Please Enter Your Email");
                      } else if (passwordController.text.isEmpty) {
                        mySnackBar(title: "Validation", message: "Please Enter Your Password");
                      } else if (confirmPasswordController.text.isEmpty) {
                        mySnackBar(title: "Validation", message: "Please Confirm Your Password");
                      } else if (passwordController.text != confirmPasswordController.text) {
                        mySnackBar(title: "Validation", message: "Passwords do not match");
                      } else {
                        // Perform signup
                        final response = await http.get(
                          Uri.parse("http://localhost/myapis/signup.php?email=${emailController.text}&password=${passwordController.text}&phone=${phoneController.text}&fname=${firstNameController.text}&sname=${otherNameController.text}"),
                        );

                        if (response.statusCode == 200) {
                          final serverData = jsonDecode(response.body);
                          
                          if (serverData['success'] == 1) {
                            mySnackBar(title: 'Success', message: 'You are registered');
                            Get.offAll(() => const LoginScreen());
                          } else {
                            mySnackBar(title: 'Error', message: serverData['message']);
                          }
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {
                      // Navigate to the Login screen
                      Get.to(() => LoginScreen());
                    },
                    child: const Text(
                      'Already Registered? Login',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}