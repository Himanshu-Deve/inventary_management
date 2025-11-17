import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management/config/constant.dart';


class AppUtils {
  AppUtils._(); // private constructor

  /// Get the current BuildContext from navigatorKey
  static BuildContext? get _context => AppGlobals.navigatorKey.currentContext;

  /// Show a Snackbar (context-free)
  static void showSnackbar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    double borderRadius = 8.0,
    EdgeInsetsGeometry? margin,
    SnackBarAction? action,
  }) {
    final context = _context;
    if (context == null) return;

    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      duration: duration,
      backgroundColor: backgroundColor,
      behavior: behavior,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      action: action,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Show toast
  static void showToast(
      String message, {
        Duration duration = const Duration(seconds: 2),
        Color backgroundColor = Colors.black87,
        Color textColor = Colors.white,
        double borderRadius = 8.0,
        EdgeInsetsGeometry? margin,
      }) {
    showSnackbar(
      message: message,
      duration: duration,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderRadius: borderRadius,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  /// Show success toast
  static void showSuccess(String message, {Duration duration = const Duration(seconds: 3)}) {
    showToast(
      message,
      backgroundColor: Colors.green[600]!,
      duration: duration,
    );
  }

  /// Show error toast
  static void showError(String message, {Duration duration = const Duration(seconds: 3)}) {
    showToast(
      message,
      backgroundColor: Colors.red[600]!,
      duration: duration,
    );
  }

  /// Show info toast
  static void showInfo(String message, {Duration duration = const Duration(seconds: 3)}) {
    showToast(
      message,
      backgroundColor: Colors.blue[600]!,
      duration: duration,
    );
  }

  /// Show warning toast
  static void showWarning(String message, {Duration duration = const Duration(seconds: 3)}) {
    showToast(
      message,
      backgroundColor: Colors.orange[700]!,
      duration: duration,
    );
  }

  /// Show a custom dialog
  static void showCustomPopup({
    required String title,
    required Widget content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    bool barrierDismissible = true,
    bool showCloseIcon = true,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(24.0),
    double borderRadius = 16.0,
    Color? backgroundColor,
    bool showConfirmButton = true,
    bool showCancelButton = true,
    double elevation = 8.0,
    bool showDivider = true,
    IconData? closeIcon,
    Color? titleColor,
    double maxWidth = 500,
  }) {
    final context = _context;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Dialog(
          backgroundColor: backgroundColor ?? theme.dialogBackgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: contentPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: titleColor ?? theme.colorScheme.onSurface,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (showCloseIcon)
                        Positioned(
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark ? Colors.grey[800] : Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                closeIcon ?? Icons.close_rounded,
                                size: 20,
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                              onPressed: () => context.pop(),
                              padding: const EdgeInsets.all(4),
                              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                              splashRadius: 20,
                            ),
                          ),
                        ),
                    ],
                  ),

                  if (showDivider) ...[
                    const SizedBox(height: 16),
                    Divider(height: 1, color: theme.dividerColor.withOpacity(0.3)),
                  ],

                  const SizedBox(height: 20),

                  Flexible(child: SingleChildScrollView(child: content)),

                  const SizedBox(height: 24),

                  if ((showConfirmButton && confirmText != null) || (showCancelButton && cancelText != null))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (showCancelButton && cancelText != null)
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: OutlinedButton(
                                onPressed: () {
                                  onCancel?.call();
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: cancelButtonColor ?? theme.colorScheme.onSurface,
                                  side: BorderSide(color: theme.colorScheme.outline.withOpacity(0.3)),
                                  backgroundColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(cancelText, style: const TextStyle(fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        if (showConfirmButton && confirmText != null)
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  onConfirm?.call();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: confirmButtonColor ?? theme.colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Text(confirmText,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
