import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

class StyledTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool isDark;
  final void Function(String)? onChange;
  final TextInputType? keyboardType;
  final bool? readOnly;

  const StyledTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.onChange,
    required this.isDark,
    this.keyboardType,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChange,
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDark ? TColors.white : TColors.black,
        ),
        hintStyle: GoogleFonts.raleway(fontSize: 14),
        floatingLabelStyle: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDark ? TColors.white : TColors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: isDark ? TColors.white : TColors.accent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: isDark ? TColors.white : TColors.accent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: isDark ? TColors.white : TColors.primary,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      ),
      style: GoogleFonts.raleway(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? TColors.white : TColors.black,
      ),
    );
  }
}
