import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/widgets/custom_loader.dart';
import 'package:flutter/material.dart';

import '../constants/sized_box.dart';
class RoundEdgedButton extends StatelessWidget {
  final double? height;
  final Color color;
  final String text;
  final String fontfamily;
  final Function()? onTap;
  final double horizontalMargin;
  final double verticalPadding;
  final double verticalMargin;
  // final Gradient? gradient;
  final bool isSolid;
  final bool isWhite;
  final Color? textColor;
  final double? borderRadius;
  final bool isBold;
  final double? fontSize;
  final double? width;
  final String? icon;
  final bool showGradient;
  final  FontWeight?  fontWeight;
  final bool load;

  const RoundEdgedButton(
      {Key? key,
        this.color = MyColors.primaryColor,
      required this.text,
        this.isWhite = false,
        this.fontfamily = 'Regular',
      this.onTap,
        this.horizontalMargin=0,
        this.textColor,
        this.borderRadius,
        this.isBold = false,
        this.verticalMargin = 12,
        this.verticalPadding = 0,
        // 13,
        this.width,
        this.fontSize=15,
        this.icon,
        this.showGradient = false,
        this.height=50,
        this.fontWeight= FontWeight.w600,
        this.load = false,

        // required this.hasGradient,
      this.isSolid=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:load?null: onTap,
      child: Container(
         height: height,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin,vertical: verticalMargin),
        width: width??(MediaQuery.of(context).size.width),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: verticalPadding),
        decoration: BoxDecoration(
          color:isWhite?Colors.white:isSolid? color:Colors.transparent,
          // gradient: hasGradient?gradient ??
          //     LinearGradient(
          //       colors: <Color>[
          //         Color(0xFF064964),
          //         Color(0xFF73E4D9),
          //       ],
          //     ):null,
            gradient:showGradient? const LinearGradient(
              // begin: FractionalOffset.topRight,
              // end: FractionalOffset.bottomCenter,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors:  [
                Color(0xfff02321),
                Color(0xff781211),
              ],
            ):null,
          borderRadius: BorderRadius.circular(borderRadius??10),
          border:isSolid?null: Border.all(color: color),
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(icon!=null)
            Image.asset(icon!,height:12,),
            if(icon!=null)
              hSizedBox,
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:textColor??(isWhite?MyColors.primaryColor:isSolid? Colors.white:color),
                fontSize: fontSize??24,
                fontWeight:fontWeight??FontWeight.w600,
                 fontFamily:'Regular',



                // fontWeight:isBold?FontWeight.w700: FontWeight.w500,

                // letterSpacing: 2,
              ),
            ),
            if(load)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CustomLoader(color:textColor??(isWhite?MyColors.primaryColor:isSolid? Colors.white:color),),
              )


          ],
        )
      ),
    );
  }
}
