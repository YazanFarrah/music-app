import 'package:client/config/style_constants.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/validators/general_validations.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:client/core/widgets/custom_text_with_form_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SignupPasswordWidget extends StatefulWidget {
  const SignupPasswordWidget({super.key});

  @override
  State<SignupPasswordWidget> createState() => _SignupPasswordWidgetState();
}

class _SignupPasswordWidgetState extends State<SignupPasswordWidget> {
  final _passwordController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isPassValid = false;
  bool _showPass = false;

  @override
  void initState() {
    super.initState();

    _focusNode.requestFocus();
    final provider = Provider.of<AuthViewModel>(context, listen: false);
    _passwordController.text = provider.userModel?.password ?? "";
    _passwordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final password = _passwordController.text.trim();
    setState(() {
      _isPassValid = AppValidation.passwordValidator(password, context) == null;
    });
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validatePassword);
    _passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: StyleConstants.horizontalPadding,
      child: Column(
        children: [
          TextWithTextField(
            focusNode: _focusNode,
            contentPadding: 0,
            verticalPadding: 0,
            width: double.infinity,
            text: "enterPassword".tr(),
            textStyle: Theme.of(context).textTheme.headlineLarge,
            controller: _passwordController,
            isPass: !_showPass,
            suffix: GestureDetector(
              child: Icon(
                _showPass ? Icons.visibility : Icons.visibility_off,
                color: SharedColors.greyTextColor,
              ),
              onTap: () {
                setState(() {
                  _showPass = !_showPass;
                });
              },
            ),
          ),
          CustomButton(
            onPressed: _isPassValid
                ? () {
                    context
                        .read<AuthViewModel>()
                        .updatePassword(_passwordController.text.trim());
                    context.read<AuthViewModel>().nextPage();
                  }
                : () {},
            text: "next".tr(),
            backgroundColor: _isPassValid ? null : SharedColors.greyTextColor,
          ),
        ],
      ),
    );
  }
}
