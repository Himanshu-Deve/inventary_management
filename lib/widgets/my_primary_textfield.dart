import 'package:flutter/material.dart';

class MyPrimaryTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final String? prefixText;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final bool autoValidate;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color errorBorderColor;
  final double borderRadius;
  final bool showCounter;
  final bool isDense;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final VoidCallback? onSuffixPressed;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<String>? autofillHints;

  const MyPrimaryTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixWidget,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.autoValidate = false,
    this.focusedBorderColor = Colors.green,
    this.enabledBorderColor = Colors.black,
    this.errorBorderColor = Colors.red,
    this.borderRadius = 12.0,
    this.showCounter = false,
    this.isDense = false,
    this.contentPadding,
    this.focusNode,
    this.onSuffixPressed,
    this.readOnly = false,
    this.onTap,
    this.autofillHints,
  }) : super(key: key);

  @override
  State<MyPrimaryTextField> createState() => _MyPrimaryTextFieldState();
}

class _MyPrimaryTextFieldState extends State<MyPrimaryTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isObscured = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _isObscured = widget.obscureText;
    _focusNode.addListener(_onFocusChange);
    if (widget.autoValidate) {
      widget.controller.addListener(_validateField);
    }
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
    if (!_focusNode.hasFocus && widget.autoValidate) {
      _validateField();
    }
  }

  void _validateField() {
    if (widget.validator != null) {
      final error = widget.validator!(widget.controller.text);
      setState(() => _errorText = error);
    }
  }

  void _toggleObscureText() => setState(() => _isObscured = !_isObscured);

  Widget? _buildSuffixIcon() {
    if (widget.suffixWidget != null) return widget.suffixWidget;
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey[600],
        ),
        onPressed: _toggleObscureText,
      );
    }
    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(widget.suffixIcon, color: Colors.grey[600]),
        onPressed: widget.onSuffixPressed,
      );
    }
    return null;
  }

  Color _getBorderColor() {
    if (_errorText != null && _errorText!.isNotEmpty) {
      return widget.errorBorderColor;
    }
    return _isFocused ? widget.focusedBorderColor : widget.enabledBorderColor;
  }

  double _getBorderWidth() =>
      (_errorText != null && _errorText!.isNotEmpty) ? 1.5 : (_isFocused ? 1.5 : 1);

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) _focusNode.dispose();
    if (widget.autoValidate) {
      widget.controller.removeListener(_validateField);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveErrorText = _errorText ?? widget.errorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
        ],
        Container(
          decoration: BoxDecoration(
            color: widget.enabled ? Colors.white : Colors.grey[100],
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _getBorderColor(),
              width: _getBorderWidth(),
            ),
            boxShadow: _isFocused
                ? [
              BoxShadow(
                color: widget.focusedBorderColor.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              if (widget.prefixText != null) ...[
                Text(
                  widget.prefixText!,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
              ] else if (widget.prefixIcon != null) ...[
                Icon(widget.prefixIcon, color: Colors.grey[600]),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  obscureText: _isObscured,
                  enabled: widget.enabled,
                  maxLines: widget.maxLines,
                  maxLength: widget.maxLength,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  readOnly: widget.readOnly,
                  onTap: widget.onTap,
                  autofillHints: widget.autofillHints,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: InputBorder.none,
                    counterText: widget.showCounter ? null : '',
                    isDense: widget.isDense,
                  ),
                  onChanged: (value) {
                    if (widget.autoValidate) _validateField();
                    widget.onChanged?.call(value);
                  },
                  onSubmitted: widget.onSubmitted,
                ),
              ),
              if (_buildSuffixIcon() != null) _buildSuffixIcon()!,
            ],
          ),
        ),
        if (effectiveErrorText != null && effectiveErrorText.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            effectiveErrorText,
            style: TextStyle(
              color: widget.errorBorderColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ] else if (widget.helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.helperText!,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
