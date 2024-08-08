import 'package:client/config/style_constants.dart';
import 'package:client/core/utils/capitalize.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:client/core/widgets/custom_text_with_form_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';

import 'package:client/core/enums/gender.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupGenderWidget extends StatefulWidget {
   

  const SignupGenderWidget({
    super.key,
      
  });

  @override
  State<SignupGenderWidget> createState() => _SignupGenderWidgetState();
}

class _SignupGenderWidgetState extends State<SignupGenderWidget> {
  final _genderController = TextEditingController();
  Gender? selectedGender;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AuthViewModel>(context, listen: false);
    _genderController.text = _translateGender(
      provider.userModel?.gender ?? Gender.male,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openGenderPicker();
    });
  }

  String _translateGender(Gender gender) {
    switch (gender) {
      case Gender.male:
        return 'male'.tr().capitalize();
      case Gender.female:
        return 'female'.tr().capitalize();
      default:
        return '';
    }
  }

  void _updateGender(Gender gender) {
    final viewModel = context.read<AuthViewModel>();
    setState(() {
      selectedGender = gender;
      _genderController.text = _translateGender(gender);
      viewModel.updateGender(gender);
    });
  }

  void _openGenderPicker() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 220.h,
          child: Column(
            children: [
              Container(
                height: 50.h,
                color: Theme.of(context).bottomSheetTheme.backgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                          if (_genderController.text.isNotEmpty) {
                              context                  .read<AuthViewModel>().nextPage();
                          }
                        },
                        child: Text(
                          'done'.tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  backgroundColor:
                      Theme.of(context).bottomSheetTheme.backgroundColor,
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    _updateGender(Gender.values[index]);
                  },
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedGender != null
                        ? Gender.values.indexOf(selectedGender!)
                        : 0,
                  ),
                  children: Gender.values.map(
                    (gender) {
                      return Center(
                        child: Text(
                          _translateGender(gender),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the gender controller with the current state value

    return Padding(
      padding: StyleConstants.horizontalPadding,
      child: Column(
        children: [
          GestureDetector(
            onTap: _openGenderPicker,
            child: TextWithTextField(
              enabled: false,
              controller: _genderController,
              contentPadding: 0,
              verticalPadding: 0,
              width: double.infinity,
              text: "selectGender".tr(),
              textStyle: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          CustomButton(
            onPressed: () {
              if (_genderController.text.isNotEmpty) {
                  context                  .read<AuthViewModel>().nextPage();
              }
            },
            text: "next".tr(),
          ),
        ],
      ),
    );
  }
}
