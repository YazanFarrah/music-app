import 'package:client/config/app_constants.dart';
import 'package:client/config/asset_paths.dart';
import 'package:client/core/router/route_paths.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
          child: Column(
            children: [
              Image.asset(
                AssetPaths.appLogo,
                width: 65.w,
              ),
              SizedBox(height: 20.h),
              Text(
                "millionsOfSongs".tr(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 5.h),
              Text(
                "${"freeOn".tr()} ${AppConstants.appName}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 20.h),
              CustomButton(
                width: double.infinity,
                onPressed: () {
                  context.pushNamed(RoutePaths.signup);
                },
                text: "signUpFree".tr(),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                width: double.infinity,
                icon: SvgPicture.asset(
                  AssetPaths.googleSvg,
                  width: 30.w,
                ),
                label: "continueWithGoogle",
                onPressed: () {},
                backgroundColor: Colors.transparent,
                borderColor: SharedColors.greyTextColor,
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  context.pushNamed(RoutePaths.login);
                },
                child: Text(
                  "login".tr(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
