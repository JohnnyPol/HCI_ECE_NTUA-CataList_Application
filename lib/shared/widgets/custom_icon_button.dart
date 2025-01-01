import 'package:flutter/material.dart';
import '../../app_export.dart';

extension IconButtonStyleHelper on CustomIconButton {
  // Updated to remove the outline and shadow
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: appTheme.profileAvatar,
        borderRadius: BorderRadius.circular(30.h),
        // No shadow or border applied here
      );

  static BoxDecoration get none => BoxDecoration(); // No decoration at all
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.decoration,
    this.padding,
    this.onTap,
    this.child,
  }) : super(key: key);

  final Alignment? alignment;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: DecoratedBox(
          decoration: decoration ??
              BoxDecoration(
                color: appTheme.homeBGcolor1,
                borderRadius: BorderRadius.circular(28.h),
                // Removed the border to ensure no outline
                // border: Border.all(
                //   color: appTheme.black900,
                //   width: 1.h,
                // ),
              ),
          child: IconButton(
            padding: padding ?? EdgeInsets.zero,
            onPressed: onTap,
            icon: child ?? Container(),
          ),
        ),
      );
}