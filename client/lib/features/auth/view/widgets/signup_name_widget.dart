import 'package:client/config/style_constants.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/validators/general_validations.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:client/core/widgets/custom_text_with_form_field.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupNameWidget extends StatefulWidget {
  const SignupNameWidget({super.key});

  @override
  State<SignupNameWidget> createState() => _SignupNameWidgetState();
}

class _SignupNameWidgetState extends State<SignupNameWidget> {
  final _nameController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isNameValid = false;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    final provider = Provider.of<AuthViewModel>(context, listen: false);
    _nameController.text = provider.userModel?.name ?? "";
    _nameController.addListener(_validateName);
  }

  void _validateName() {
    final name = _nameController.text.trim();
    setState(() {
      _isNameValid = AppValidation.nameValidator(name, context) == null;
    });
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateName);
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AuthViewModel>();
    final isLoading = context.watch<AuthViewModel>().isLoading;

    return isLoading
        ? const Loader()
        : Padding(
            padding: StyleConstants.horizontalPadding,
            child: Column(
              children: [
                TextWithTextField(
                  focusNode: _focusNode,
                  contentPadding: 0,
                  verticalPadding: 0,
                  width: double.infinity,
                  text: "enterName".tr(),
                  textStyle: Theme.of(context).textTheme.headlineLarge,
                  controller: _nameController,
                ),
                CustomButton(
                  onPressed: _isNameValid && !isLoading
                      ? () async {
                          viewModel.updateName(_nameController.text.trim());
                          await viewModel.signup(context: context);
                        }
                      : () {},
                  text: "signup".tr(),
                  backgroundColor:
                      _isNameValid ? null : SharedColors.greyTextColor,
                ),
              ],
            ),
          );
  }
}
