import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon, this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400, // lighter than w500 or w600
          color: Colors.grey.shade500, )
        ,
        prefixIcon: Icon(prefixIcon,color: primaryRed,),
        suffixIcon: suffixIcon != null ? GestureDetector(
            onTap: onSuffixTap,
            child: Icon(suffixIcon) ): null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE4E7EB)),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE4E7EB)),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: validator,
    );
  }
}
