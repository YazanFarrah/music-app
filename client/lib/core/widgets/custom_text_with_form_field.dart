import 'package:client/core/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWithTextField extends StatefulWidget {
  const TextWithTextField({
    super.key,
    required this.text,
    required this.controller,
    this.textStyle,
    this.errorString,
    this.hintText,
    this.isPass,
    this.keyType,
    this.maxLength,
    this.radius,
    this.contentPadding,
    this.verticalPadding,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.onChanged,
    this.filled,
    this.hasBorderSide,
    this.enabled,
    this.width,
    this.suffix,
    this.numbersOnly,
  });

  final String text;
  final TextStyle? textStyle;
  final TextEditingController controller;
  final String? errorString;
  final String? hintText;
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
  final bool? filled;
  final bool? hasBorderSide;
  final bool? enabled;
  final double? width;
  final Widget? suffix;
  final bool? numbersOnly;

  @override
  State<TextWithTextField> createState() => _TextWithTextFieldState();
}

class _TextWithTextFieldState extends State<TextWithTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.errorString != null
              ? Row(
                  children: [
                    Text(
                      widget.text,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Text(
                        widget.errorString!,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: Colors.red,
                                ),
                      ),
                    ),
                  ],
                )
              : Text(
                  widget.text,
                  style: widget.textStyle ??
                      Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                ),
          SizedBox(height: 10.h),
          SizedBox(
            width: widget.width ?? MediaQuery.of(context).size.width * 0.4,
            height: 60.h,
            child: CustomFormField(
              hintText: widget.hintText,
              controller: widget.controller,
              isPass: widget.isPass,
              keyType: widget.keyType,
              maxLength: widget.maxLength,
              radius: widget.radius,
              numbersOnly: widget.numbersOnly,
              contentPadding: widget.contentPadding ?? 10,
              verticalPadding: widget.verticalPadding,
              validator: widget.validator,
              focusNode: widget.focusNode,
              onEditingComplete: widget.onEditingComplete,
              onChanged: (widget.onChanged != null)
                  ? widget.onChanged
                  : (widget.errorString != null)
                      ? (p0) {
                          setState(() {});
                        }
                      : null,
              filled: widget.filled,
              hasBorderSide: widget.hasBorderSide,
              enabled: widget.enabled,
              suffix: widget.suffix,
            ),
          ),
        ],
      ),
    );
  }
}
