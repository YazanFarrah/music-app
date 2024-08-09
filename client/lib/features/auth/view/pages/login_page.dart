import 'package:client/config/style_constants.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/validators/general_validations.dart';
import 'package:client/core/widgets/custom_app_bar.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:client/core/widgets/custom_text_with_form_field.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LloginPageState();
}

class LloginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPass = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthViewModel>(context).isLoading;
    return isLoading
        ? const Loader()
        : Scaffold(
            appBar: CustomAppBar(title: "login".tr()),
            body: Padding(
              padding: StyleConstants.horizontalPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextWithTextField(
                      contentPadding: 0,
                      verticalPadding: 0,
                      width: double.infinity,
                      text: "email".tr(),
                      hintText: "yaz@example.com",
                      textStyle: Theme.of(context).textTheme.headlineLarge,
                      controller: _emailController,
                      validator: (value) =>
                          AppValidation.emailValidator(value, context),
                      keyType: TextInputType.emailAddress,
                    ),
                    TextWithTextField(
                      contentPadding: 0,
                      verticalPadding: 0,
                      width: double.infinity,
                      text: "password".tr(),
                      textStyle: Theme.of(context).textTheme.headlineLarge,
                      controller: _passwordController,
                      validator: (value) =>
                          AppValidation.passwordValidator(value, context),
                      keyType: TextInputType.emailAddress,
                      hintText: "♪♪♪♪♪♪♪♪♪♪",
                      isPass: !_showPass,
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPass = !_showPass;
                          });
                        },
                        child: Icon(
                          _showPass ? Icons.visibility : Icons.visibility_off,
                          color: SharedColors.greyTextColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      width: double.infinity,
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await context.read<AuthViewModel>().login(
                                context: context,
                                email: _emailController.text.toString(),
                                password: _passwordController.text.trim(),
                              );
                        }
                      },
                      text: "next".tr(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
