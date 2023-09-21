import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/constants/image_urls.dart';
import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/functions/navigation_functions.dart';
import 'package:aledit_logistica/widgets/custom_circular_image.dart';
import 'package:aledit_logistica/widgets/custom_text.dart';
import 'package:aledit_logistica/widgets/round_edged_button.dart';
import 'package:flutter/material.dart';

showCommonAlertDailog(BuildContext context,
    {String? message,
    String? headingText,
    String? cancelButtonText,
    String? confirmButtonText,
    bool successIcon = true,
    String? imageUrl,
    List<Widget>? actions}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.3),
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        title: imageUrl != null
            ? Center(
                child: CustomCircularImage(
                  imageUrl: imageUrl,
                  fileType: CustomFileType.asset,
                  height: 50,
                  width: 50,
                ),
              )
            : successIcon
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border:
                              Border.all(color: MyColors.greenColor, width: 2)),
                      child: const Icon(
                        Icons.done_outline_sharp,
                        color: MyColors.greenColor,
                        size: 45,
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      // padding: const EdgeInsets.all(10),
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(
                        Icons.error_outline_outlined,
                        color: MyColors.primaryColor,
                        size: 60,
                      ),
                    ),
                  ),
        actions: actions ??
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RoundEdgedButton(
                    text: "Cancel",
                    color: MyColors.textFeildFillColor,
                    textColor: MyColors.blackColor,
                    width: 100,
                    height: 40,
                    onTap: () {
                      popPage(context: context);
                    },
                  ),
                  hSizedBox2,
                  RoundEdgedButton(
                    text: confirmButtonText??"Ok",
                    width: 100,
                    height: 40,
                    onTap: () {
                      Navigator.pop(context,true);
                    },
                  ),
                  hSizedBox,
                ],
              ),
            ],
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                fontSize: 16,
                color: MyColors.blackColor,
              ),
            vSizedBox,
          ],
        ),
      );
    },
  );
}
