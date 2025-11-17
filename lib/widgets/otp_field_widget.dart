import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPTextField extends StatelessWidget {
  final int length;
  final Function(String) onCompleted;
  final TextEditingController? controller;
  final double spacing;

  const OTPTextField({
    Key? key,
    this.length = 4,
    required this.onCompleted,
    this.controller,
    this.spacing = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Pinput(
        length: length,
        controller: controller,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        showCursor: true,
        onCompleted: onCompleted,
        separatorBuilder: (index) => SizedBox(width: spacing), // Correct way
      ),
    );
  }
}