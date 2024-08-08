import 'package:client/features/auth/view/widgets/signup_birthday_widget.dart';
import 'package:client/features/auth/view/widgets/signup_email_widget.dart';
import 'package:client/features/auth/view/widgets/signup_gender_widget.dart';
import 'package:client/features/auth/view/widgets/signup_name_widget.dart';
import 'package:client/features/auth/view/widgets/signup_password_widget.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:client/core/widgets/custom_app_bar.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Future<bool> _onWillPop() async {
    final pageController = Provider.of<AuthViewModel>(context, listen: false);
    final currentPage = pageController.currentPage;

    if (currentPage == 0) {
      // If on the first page, clear the pageController and pop the page
      context.read<AuthViewModel>().clear();
      return true;
    } else {
      // Go to the previous page
      pageController.previousPage();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageController = Provider.of<AuthViewModel>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "createAccount".tr(),
          onBack: () async {
            await _onWillPop().then((shouldPop) {
              if (shouldPop) {
                context.pop();
              }
            });
          },
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController.pageController,
          children: const [
            SignupEmailWidget(),
            SignupPasswordWidget(),
            SignupBirthdayWidget(),
            SignupGenderWidget(),
            SignupNameWidget(),
          ],
        ),
      ),
    );
  }
}
