

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_discharge/Screens/authentication/LoginScreen/google_sign.dart';
import 'package:post_discharge/util/Constants/images.dart';
import 'package:post_discharge/util/Constants/sizes.dart';


class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {
              Get.to(()=>SignInPage());
            },
            icon: const Image(
              width: MySizes.md,
              height: MySizes.md,
              image: AssetImage(MyImages.google),
            ),
          ),
        ),
        const SizedBox(
          width: MySizes.spacebtwnItems,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: MySizes.md,
              height: MySizes.md,
              image: AssetImage(MyImages.facebook),
            ),
          ),
        ),
        const SizedBox(
          width: MySizes.spacebtwnItems,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: MySizes.md,
              height: MySizes.md,
              image: AssetImage(MyImages.instagram),
            ),
          ),
        ),
        const SizedBox(
          height: MySizes.spacebtwnSections,
        ),
      ],
    );
  }
}
