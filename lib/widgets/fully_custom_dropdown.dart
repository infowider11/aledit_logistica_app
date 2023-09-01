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
    this.bgColor =  MyColors.textFeildFillColor,
    required this.selectedItem,
    this.headingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      height: headingText==null?48:72,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color:bgColor,
        borderRadius: BorderRadius.circular(8),
        // border:headingText!=null?null: Border.all(color: MyColors.black54Color,width: 0.1),
      ),
      padding:headingText!=null?null: EdgeInsets.only(left: 16, right: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(headingText!=null)
          SubHeadingText( headingText!),
          DropdownButtonFormField(
            decoration: InputDecoration(

               border:headingText==null? InputBorder.none:null,
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
