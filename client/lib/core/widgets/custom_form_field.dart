import 'package:client/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool? isPass;
  final TextInputType? keyType;
  final int? maxLength;
  final double? radius;
  final double? contentPadding;
  final double? verticalPadding;
  final FormFieldValidator? validator;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool? filled;
  final bool? hasBorderSide;
  final bool? enabled;
  final Widget? suffix;
  final bool? numbersOnly;
  final TextInputAction? textInputAction;
  final bool? readOnly;
  final VoidCallback? onTap;

  const CustomFormField({
    super.key,
    this.hintText,
    this.controller,
    this.isPass,
    this.keyType,
    this.maxLength,
    this.radius,
    this.contentPadding,
    this.verticalPadding,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.filled,
    this.hasBorderSide = true,
    this.enabled,
    this.onChanged,
    this.suffix,
    this.numbersOnly,
    this.textInputAction,
    this.readOnly = false,
    this.onTap,
  });

  _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly!,
      style: const TextStyle(color: Colors.white), // Change text color here

      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      inputFormatters: [
        if (numbersOnly == true) FilteringTextInputFormatter.digitsOnly
      ],
      obscuringCharacter: "♪",

      decoration: InputDecoration(
        border: InputBorder.none, // Removes the underline
        contentPadding: EdgeInsets.symmetric(vertical: verticalPadding?? 14.h, horizontal: 20.w),
        enabledBorder: _border(AppDarkColors.borderColor),
        focusedBorder: _border(
          AppDarkColors.primaryColor,
        ),
        
        suffixIcon: suffix,
        filled: filled ?? false,

        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: SharedColors.redColor),
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 10),
          ),
        ),
        errorStyle: const TextStyle(height: 0),

        focusedErrorBorder: _border(
          AppDarkColors.redColor,
        ),

        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
        disabledBorder: _border(
          AppDarkColors.borderColor,
        ),

        hintText: hintText,
      ),
      enabled: enabled ?? true,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validator,
      maxLength: maxLength,
      keyboardType: keyType,
      obscureText: isPass ?? false,
      controller: controller,
      textInputAction: textInputAction,
      maxLines: 1,
    );
  }
}
