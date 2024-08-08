import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? fontSize;
  final Widget? child;
  final double? height;
  final double? width;
  final double? elevation;
  final double borderRadius;
  final Widget? icon;
  final String? label;
  final bool? darkText;
  final String? text;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.fontSize,
    this.child,
    this.height = 50,
    this.width,
    this.elevation,
    this.borderRadius = 8.0, // Default border radius
    this.icon,
    this.label,
    this.darkText,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: icon != null && label != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                elevation: elevation ?? 0,
                backgroundColor:
                    backgroundColor ?? Theme.of(context).primaryColor,
                side: borderColor != null
                    ? BorderSide(
                        color: borderColor ?? Colors.white,
                        width: 1,
                      )
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              label: Text(
                label!,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              icon: icon!,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                elevation: elevation ?? 0,
                backgroundColor:
                    backgroundColor ?? Theme.of(context).primaryColor,
                side: borderColor != null
                    ? BorderSide(
                        color: borderColor ?? Colors.white,
                        width: 1,
                      )
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: text != null
                  ? Text(
                      text!,
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  : child,
            ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Widget child;
  final double? height;
  final double? width;

  final double borderRadius;

  const RoundedButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    required this.child,
    this.height,
    this.width,
    this.borderRadius = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: child,
        ),
      ),
    );
  }
}
