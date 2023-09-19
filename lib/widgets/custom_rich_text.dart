import 'package:aledit_logistica/constants/colors.dart';
import 'package:flutter/material.dart';

class RichTextCustomWidget extends StatelessWidget {
  String firstText;
  String secondText;
  double? firstTextFontSize;
  double? secondTextFontSize;
  Color? firstTextColor;
  Color? secondTextColor;
  FontWeight? firstTextFontweight;
  String? firstTextFontFamily;
  String? secondTextFontFamily;
  FontWeight? secondTextFontweight;

  RichTextCustomWidget({
    required this.firstText,
    required this.secondText,
    this.firstTextFontFamily,
    this.secondTextFontFamily,
    this.firstTextFontSize = 16.0,
    this.secondTextFontSize = 16.0,
    this.firstTextColor = MyColors.blackColor,
    this.secondTextColor = MyColors.primaryColor,
    this.firstTextFontweight = FontWeight.w600,
    this.secondTextFontweight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return  RichText(
        text: TextSpan(
          text: firstText,
          
          style: TextStyle(
            
              fontFamily: firstTextFontFamily,
              fontSize: firstTextFontSize,
              color: firstTextColor,
              fontWeight: firstTextFontweight),
          children: <TextSpan>[
            TextSpan(
              text: secondText,
              
              style: TextStyle(
                  fontFamily: secondTextFontFamily,
                  fontSize: secondTextFontSize,
                  color: secondTextColor,
                  fontWeight: secondTextFontweight),
            ),
          ],
        ),
      
    );
  }
}
