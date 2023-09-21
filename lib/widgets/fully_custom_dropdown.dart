import 'package:aledit_logistica/constants/image_urls.dart';
import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'custom_text.dart';

// TextStyle textFieldHintTextStyle = TextStyle(
//   // color: MyColors.blackColor,
//   color: MyColors.blackColor,
//   fontSize: 13,
// );

TextStyle textFieldTextStyle = TextStyle(
  // color: MyColors.blackColor,
  color: MyColors.blackColor,
  fontSize: 13,
);

class CustomDropDown extends StatelessWidget {
  List<DropdownMenuItem>? items;
  final Function(dynamic) onChanged;
  final String hint;
  final Color bgColor;
  final dynamic selectedItem;
  final String? headingText;
  CustomDropDown({
    Key? key,
    this.items,
    required this.onChanged,
    required this.hint,
    this.bgColor = MyColors.textFeildFillColor,
    required this.selectedItem,
    this.headingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      height: headingText == null ? 48 : 72,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        // border:headingText!=null?null: Border.all(color: MyColors.black54Color,width: 0.1),
      ),
      padding: headingText != null ? null : EdgeInsets.only(left: 16, right: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (headingText != null) SubHeadingText(headingText!),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: headingText == null ? InputBorder.none : null,
              hintText: hint,
              // filled: true,
              contentPadding: EdgeInsets.only(bottom: 10),
              hintStyle: TextStyle(
                // color: MyColors.blackColor,
                // color: MyColors.blackColor,
                fontSize: 16,
              ),
              // labelText: headingText,
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(6),
              //     borderSide: BorderSide(color: Colors.green, width: 6),
              //   gapPadding: 5
              // ),
              // fillColor: Colors.white,
              isDense: false,
            ),
            items: items,
            onChanged: onChanged,
            isExpanded: true,
            style: textFieldTextStyle,
            menuMaxHeight: 300,
            value: selectedItem,
          ),
        ],
      ),
    );
  }
}

class CustomDropDownFeild extends StatelessWidget {
  final List itemsList;
  final Color? hintcolor;
  final String hintText;
  final String? headingText;
  final Map<String, dynamic>? selectedValue;
  final double? headingfontSize;
  final double borderRadius;
  final bool showRequiredHint;
  final String valueKey;
  final String popUpTextKey;
  final String? Function(dynamic)? validator;
  final Function(dynamic)? onChanged;

  const CustomDropDownFeild({
    super.key,
    required this.itemsList,
    this.headingfontSize = 15,
    this.borderRadius = 6,
    this.headingText,
    this.showRequiredHint = false,
    required this.popUpTextKey,
    required this.valueKey,
    this.hintcolor,
    this.selectedValue,
    this.onChanged,
    this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (headingText != null)
          RichTextCustomWidget(
            firstText: headingText!,
            firstTextFontSize: 19,
            firstTextFontweight: FontWeight.w500,
            secondText: showRequiredHint
                ? validator == null
                    ? "  (optional)"
                    : " *"
                : '',
            secondTextColor:
                validator == null ? MyColors.blackColor : MyColors.redColor,
            secondTextFontSize: validator == null ? 10 : 16,
            secondTextFontweight:
                validator == null ? FontWeight.w300 : FontWeight.w600,
          ),
        if (headingText != null) vSizedBox,
        DropdownButtonFormField(
          value: selectedValue,
          isDense: true,
           isExpanded: true,
           menuMaxHeight: 300,
           
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintcolor,
              fontSize: 16,
            ),
            labelStyle: TextStyle(
              color: hintcolor,
              fontSize: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: MyColors.textFeildFillColor, width: 1),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            filled: true,
            fillColor: MyColors.textFeildFillColor,
          ),

          dropdownColor: Colors.white,
          // ignore: avoid_print
          onChanged: onChanged,
          validator: validator,
          icon: Image.asset(
            MyImagesUrl.arrowDownDropdown,
            width: 14,
            height: 15,
          ),
          items: itemsList.map<DropdownMenuItem>((value) {
            return DropdownMenuItem(
              value: value as Map,
              child: Text(
                value[popUpTextKey],
                style: const TextStyle(
                    color: MyColors.blackColor,
                    fontSize: 15,
                    fontFamily: 'Regular'),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
