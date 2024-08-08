import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.backgroundColor = Colors.transparent,
    this.leading,
    this.centerTitle = true,
    this.bottom,
    this.flexibleSpace,
    this.popPath,
    this.popOnePage,
    this.onBack,
    this.actions,
  });

  final String title;
  final TextStyle? titleStyle;
  final Color backgroundColor;
  final Widget? leading;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;
  final String? popPath;
  final bool? popOnePage;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      flexibleSpace: flexibleSpace,
      leadingWidth: 82.w,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leading: leading ??
          IconButton(
            splashColor: Colors.transparent,
            onPressed: onBack ??
                () {
                  context.pop();
                },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
      title: Text(
        title,
        style: titleStyle ?? const TextStyle(color: Colors.white),
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
