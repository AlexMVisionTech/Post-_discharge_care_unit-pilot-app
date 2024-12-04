
import 'package:flutter/material.dart';
import 'package:post_discharge/Screens/authentication/LoginScreen/login_form.dart';
import 'package:post_discharge/Screens/authentication/LoginScreen/login_header.dart';
import 'package:post_discharge/util/Constants/screen_helpers.dart';
import 'package:post_discharge/util/Constants/sizes.dart';
import 'package:post_discharge/util/Constants/spacing_styles.dart';
import 'package:post_discharge/util/Constants/text_string.dart';
import 'package:post_discharge/util/re-usable%20widgets/formdivider.dart';
import 'package:post_discharge/util/re-usable%20widgets/formfooter.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunction.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MySpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              //logo,title and subtitle
              LoginHeader(dark: dark),
              //form
              const LoginForm(),
              //Divider
              LoginDivider(dark: dark),
              const SizedBox(
                height: MySizes.spacebtwnSections,
              ),
              //footer
              const LoginFooter(),
              const SizedBox(
                height: MySizes.spacebtwnItems,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  MyText.createdby,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
