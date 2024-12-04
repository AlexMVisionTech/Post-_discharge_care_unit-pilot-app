import 'package:flutter/material.dart';
import 'package:post_discharge/util/Constants/images.dart';
import 'package:post_discharge/util/Constants/sizes.dart';
import 'package:post_discharge/util/Constants/text_string.dart';


class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          width: MySizes.xxxl,
          height: MySizes.xxl,
          image:
              AssetImage(dark ? MyImages.logo : MyImages.logo),
        ),
        Text(
          MyText.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: MySizes.sm,
        ),
        Text(
          MyText.loginSubTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
