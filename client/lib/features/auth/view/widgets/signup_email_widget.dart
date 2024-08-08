import 'package:client/config/style_constants.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/validators/general_validations.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:client/core/widgets/custom_text_with_form_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SignupEmailWidget extends StatefulWidget {
   

  const SignupEmailWidget({
    super.key,
      
  });

  @override
  State<SignupEmailWidget> createState() => _SignupEmailWidgetState();
}

class _SignupEmailWidgetState extends State<SignupEmailWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isEmailValid = false;

  @override
  void initState() {
    final provider = Provider.of<AuthViewModel>(context, listen: false);
    _emailController.text = provider.userModel?.email ?? "";
    _focusNode.requestFocus();
    _emailController.addListener(_validateEmail);
    super.initState();
  }

  void _validateEmail() {
    final email = _emailController.text.trim();
    setState(() {
      _isEmailValid = AppValidation.emailValidator(email, context) == null;
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: StyleConstants.horizontalPadding,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextWithTextField(
              focusNode: _focusNode,
              contentPadding: 0,
              verticalPadding: 0,
              width: double.infinity,
              text: "whatsYourEmail".tr(),
              textStyle: Theme.of(context).textTheme.headlineLarge,
              controller: _emailController,
              validator: (value) =>
                  AppValidation.emailValidator(value, context),
              keyType: TextInputType.emailAddress,
            ),
            CustomButton(
              onPressed: _isEmailValid
                  ? () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context
                            .read<AuthViewModel>()
                            .updateEmail(_emailController.text.trim());
                          context                  .read<AuthViewModel>().nextPage();
                      }
                    }
                  : () {},
              text: "next".tr(),
              backgroundColor:
                  _isEmailValid ? null : SharedColors.greyTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
