import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class ETextFormField extends StatelessWidget {
  final IconData? icon;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const ETextFormField({
    super.key,
    this.icon,
    this.validator,
    this.keyboardType,
    required this.hintText,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        hintText: hintText,
        labelText: labelText,
        hintStyle: Get.textTheme.bodyLarge,
        labelStyle: Get.textTheme.bodyLarge,
        prefixIcon: Visibility(
          visible: icon != null,
          child: Icon(icon, color: TColors.accent),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }
}
