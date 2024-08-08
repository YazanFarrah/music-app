import 'package:client/config/asset_paths.dart';
import 'package:client/core/router/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';

class UserState extends StatefulWidget {
  const UserState({super.key});

  @override
  State<UserState> createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
  @override
  void initState() {
    checkUserState();
    super.initState();
  }

  void checkUserState() async {
    Future.delayed(Duration.zero, () {
      context.pushNamed(RoutePaths.auth);
    });
  }

  // Future<UserModel?> _getUser() async {
  //   final user = await hiveBoxService.getUserData();
  //   if (user != null) {
  //     Provider.of<AuthProvider>(context, listen: false).updateUser(user);
  //   }
  //   return user;
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              child: Image.asset(AssetPaths.appLogo, width: 150.w)
                  .animate()
                  .shimmer(),
            ),
            SizedBox(height: 12.h),
            RepaintBoundary(
              child: Text(
                "Muse",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Colors.white,
                    ),
              ).animate().shimmer(),
            ),
            const SizedBox(width: double.infinity),
          ],
        ),
      ),
    );
  }
}
