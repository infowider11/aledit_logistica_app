import 'package:aledit_logistica/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final int? maximumLength;
  final bool obscureText;
  final int? maxLines;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final Function? validator;
  final Color? backgroundColor;
  final Color? textColor;
  const CustomTextField(
      {super.key,
      required this.controller,
      this.obscureText = false,
      this.maximumLength,
      this.maxLines,
      this.backgroundColor,
      this.textColor,
      required this.hintText,
       this.validator,
       this.textInputType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: widget.maximumLength,
        controller: widget.controller,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines == null ? 1 : 8,
        decoration: InputDecoration(
          counterText: "",
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: MyColors.textFeildFillColor,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: MyColors.redColor,
              width: 1.5,
            ),
          ),
          // errorStyle: MyColors.fontSizeValidationError,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: MyColors.redColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: widget.backgroundColor??MyColors.textFeildFillColor,
        ),
        validator:widget.validator==null?null: (val) {
          return widget.validator!(val);
        },
        keyboardType: widget.textInputType,
        );
  }
}
