import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../utils/extensions.dart';

class StyledDropdownButtonFormField<T extends Enum> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String labelText;
  final bool isDark;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const StyledDropdownButtonFormField({
    super.key,
    required this.value,
    required this.items,
    required this.labelText,
    required this.isDark,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonFormField<T>(
      value: value,
      isDense: true,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: isDark ? TColors.white : TColors.black,
        ),
        floatingLabelStyle: textTheme.titleMedium?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: isDark ? TColors.white : TColors.black,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
      ),
      items: items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            value.displayName.replaceAll('_', ' ').toUpperCase(),
            style: textTheme.titleMedium?.copyWith(
              fontSize: 16,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
              color: isDark ? TColors.white : TColors.black,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      style: textTheme.titleMedium?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: isDark ? TColors.white : TColors.black,
      ),
      alignment: Alignment.centerLeft,
      dropdownColor: isDark ? TColors.dark : TColors.white,
    );
  }
}

class StyledDropdownButtonFormField2<T extends Enum> extends StatelessWidget {
  final T? value;
  final List<T> items;

  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const StyledDropdownButtonFormField2({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonFormField<T>(
      value: value,
      isDense: true,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: TColors.primary.withOpacity(0.05),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
      ),
      items: items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            value.displayName.replaceAll('_', ' ').capitalize!,
            style: textTheme.bodyLarge?.copyWith(
              color: Get.isDarkMode ? TColors.white : TColors.black,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      style: textTheme.titleMedium?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Get.isDarkMode ? TColors.white : TColors.black,
      ),
      alignment: Alignment.centerLeft,
      dropdownColor: Get.isDarkMode ? TColors.dark : TColors.white,
    );
  }
}

class StyledDropdownButtonFormFieldNoEnum<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String labelText;
  final bool isDark;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final Color? fillColor;

  const StyledDropdownButtonFormFieldNoEnum({
    super.key,
    required this.value,
    required this.items,
    required this.labelText,
    required this.isDark,
    required this.onChanged,
    this.validator,
		this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonFormField<T>(
      value: value,
      isDense: true,
      decoration: InputDecoration(
        labelText: labelText,
				filled: true,
        fillColor: fillColor,
        labelStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: isDark ? TColors.white : TColors.black,
        ),
        floatingLabelStyle: textTheme.titleMedium?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: isDark ? TColors.white : TColors.black,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
      ),
      items: items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            value.toString(),
            style: textTheme.titleMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? TColors.white : TColors.black,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      style: textTheme.titleMedium?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: isDark ? TColors.white : TColors.black,
      ),
      alignment: Alignment.centerLeft,
      dropdownColor: isDark ? TColors.dark : TColors.white,
    );
  }
}

class StyledDropdownButtonFormFieldClass<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String labelText;
  final bool isDark;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  const StyledDropdownButtonFormFieldClass({
    super.key,
    required this.value,
    required this.items,
    required this.labelText,
    required this.isDark,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonFormField<T>(
      value: value,
      isDense: true,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: isDark ? TColors.white : TColors.black,
        ),
        floatingLabelStyle: textTheme.titleMedium?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: isDark ? TColors.white : TColors.black,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
      ),
      items: items.map((T value) {
        return DropdownMenuItem<T>(value: value, child: value as Widget);
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      style: textTheme.titleMedium?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: isDark ? TColors.white : TColors.black,
      ),
      alignment: Alignment.centerLeft,
      dropdownColor: isDark ? TColors.dark : TColors.white,
    );
  }
}
