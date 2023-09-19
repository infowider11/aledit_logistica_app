import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/constants/image_urls.dart';
import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/widgets/custom_circular_image.dart';
import 'package:aledit_logistica/widgets/custom_text.dart';
import 'package:flutter/material.dart';

 showCommonAlertDailog(BuildContext context,
    {String? message,
    String? headingText,
    bool successIcon = true,
    String? imageUrl,
    List<Widget>? actions}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      if (actions == null) {
        Future.delayed(
          const Duration(seconds: 3),
          () => Navigator.pop(context,true),
        );
      }
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        titlePadding: EdgeInsets.symmetric(vertical: 10),
        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        title: imageUrl != null
            ? const Center(
                child: CustomCircularImage(
                  imageUrl: MyImagesUrl.qrSampleImage,
                  fileType: CustomFileType.asset,
                  height: 50,
                  width: 50,
                ),
              )
            : successIcon
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border:
                              Border.all(color: MyColors.greenColor, width: 2)),
                      child: const Icon(
                        Icons.done_outline_sharp,
                        color: MyColors.greenColor,
                        size: 60,
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      // padding: const EdgeInsets.all(10),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(
                        Icons.error_outline_outlined,
                        color: MyColors.primaryColor,
                        size: 100,
                      ),
                    ),
                  ),
        actions: actions,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (headingText != null)
              Align(
                  alignment: Alignment.center,
                  child: SubHeadingText(
                    headingText,
                    fontSize: 22,
                  )),
            if (headingText != null) vSizedBox,
            if (message != null)
              ParagraphText(
                message,
                fontSize: 13,
                color: MyColors.blackColor,
              ),
            vSizedBox,
          ],
        ),
      );
    },
  );
}
