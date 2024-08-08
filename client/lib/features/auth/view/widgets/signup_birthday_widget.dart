// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:client/config/style_constants.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:client/core/widgets/custom_text_with_form_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupBirthdayWidget extends StatefulWidget {
   

  const SignupBirthdayWidget({
    super.key,
      
  });

  @override
  State<SignupBirthdayWidget> createState() => _SignupBirthdayWidgetState();
}

class _SignupBirthdayWidgetState extends State<SignupBirthdayWidget> {
  final _birthdayController = TextEditingController();
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<AuthViewModel>(context, listen: false);
    if (viewModel.userModel?.birthday != null &&
        viewModel.userModel!.birthday.isNotEmpty) {
      selectedDate =
          DateFormat('d MMMM yyyy').parse(viewModel.userModel!.birthday);
      _birthdayController.text = viewModel.userModel!.birthday;
    } else {
      selectedDate = DateTime.now()
          .subtract(const Duration(days: 365 * 10)); // 10 years ago
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openDatePicker();
    });
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('d MMMM yyyy');
    return formatter.format(date);
  }

  void _updateDate(DateTime date) {
    final formattedDate = formatDate(date);
    setState(() {
      selectedDate = date;
      _birthdayController.text = formattedDate;
    });
    final viewModel = context.read<AuthViewModel>();
    viewModel.updateBirthday(
      formattedDate,
    ); // Ensure this matches the format required
  }

  void _openDatePicker() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300.h,
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
                          if (_birthdayController.text.isNotEmpty) {
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
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                          Theme.of(context).textTheme.displayMedium,
                    ),
                    primaryColor:
                        Theme.of(context).bottomSheetTheme.backgroundColor,
                    primaryContrastingColor:
                        Theme.of(context).bottomSheetTheme.backgroundColor,
                    barBackgroundColor:
                        Theme.of(context).bottomSheetTheme.backgroundColor,
                    scaffoldBackgroundColor:
                        Theme.of(context).bottomSheetTheme.backgroundColor,
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    dateOrder: DatePickerDateOrder.dmy,
                    initialDateTime: selectedDate,
                    onDateTimeChanged: (dateTime) {
                      _updateDate(dateTime);
                    },
                    maximumYear: DateTime.now().year - 10,
                  ),
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
    return Padding(
      padding: StyleConstants.horizontalPadding,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              _openDatePicker();
            },
            child: TextWithTextField(
              enabled: false,
              controller: _birthdayController,
              contentPadding: 0,
              verticalPadding: 0,
              width: double.infinity,
              text: "enterBirthday".tr(),
              textStyle: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          CustomButton(
            onPressed: () {
              if (_birthdayController.text.isNotEmpty) {
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
