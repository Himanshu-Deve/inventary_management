import 'package:flutter/material.dart';

enum IconPosition { left, right }

class MyPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  final double? width;
  final double? height;
  final double? minWidth;
  final double? maxWidth;
  final bool fullWidth;

  final TextStyle textStyle;

  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final BoxShadow? shadow;
  final double shadowBlurRadius;
  final Offset shadowOffset;
  final double shadowSpread;

  final Widget? icon;
  final IconPosition iconPosition;
  final MainAxisAlignment contentAlignment;

  final Gradient? gradient;

  const MyPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.fullWidth = false,
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.margin = EdgeInsets.zero,
    this.shadow,
    this.shadowBlurRadius = 5,
    this.shadowOffset = const Offset(0, 2),
    this.shadowSpread = 0,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.contentAlignment = MainAxisAlignment.center,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonContent = isLoading
        ? SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: foregroundColor,
        strokeWidth: 2,
      ),
    )
        : Row(
      mainAxisAlignment: contentAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null && iconPosition == IconPosition.left) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
        if (icon != null && iconPosition == IconPosition.right) ...[
          const SizedBox(width: 8),
          icon!,
        ],
      ],
    );

    return Container(
      width: fullWidth ? double.infinity : width,
      height: height,
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        maxWidth: maxWidth ?? double.infinity,
      ),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: shadow != null
            ? [
          BoxShadow(
            color: shadow!.color,
            blurRadius: shadowBlurRadius,
            offset: shadowOffset,
            spreadRadius: shadowSpread,
          ),
        ]
            : [],
        gradient: gradient,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: gradient == null ? backgroundColor : Colors.transparent,
          foregroundColor: foregroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          elevation: shadow != null ? 0 : 2,
        ),
        child: buttonContent,
      ),
    );
  }
}
