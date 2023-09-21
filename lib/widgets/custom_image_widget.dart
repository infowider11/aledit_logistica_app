import 'package:aledit_logistica/constants/colors.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  String image;
  double? width;
  double? height;
  double borderRadius;
  Color color;
  bool is_BoxShadow;
  Function()? onTap;
  ImageWidget({
    required this.image,
    this.color = MyColors.whiteColor,
    this.borderRadius=12.0,
    this.is_BoxShadow=true,
    this.onTap,
    this.width = 30,
    this.height = 18
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
        decoration: BoxDecoration(
          boxShadow: [
            if(is_BoxShadow)
            const BoxShadow(
                color: MyColors.blackColor,
                blurRadius: 5.0,
                spreadRadius: 2.0,
                offset: Offset(0,0)
            )
          ],
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
        ),
        child: Column(
          children: [
            image.contains("https://")?Image.network(image,width: width,height: height,):
            Image.asset(image,width: width,height: height,),
          ],
        ),
      ),
    );
  }
}