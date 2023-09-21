import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/constants/global_data.dart';
import 'package:aledit_logistica/constants/image_urls.dart';
import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/modals/user_modal.dart';
import 'package:aledit_logistica/providers/auth_provider.dart';
import 'package:aledit_logistica/widgets/common_alert_dailog.dart';
import 'package:aledit_logistica/widgets/custom_image_widget.dart';
import 'package:aledit_logistica/widgets/custom_text.dart';
import 'package:aledit_logistica/widgets/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSideDrawer extends StatelessWidget {
  const CustomSideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          vSizedBox,
          Center(
            child: ImageWidget(image: MyImagesUrl.splashScreenLogo,is_BoxShadow: false,height: 100,width: 100,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: ValueListenableBuilder<UserModal?>(
              valueListenable: userDataNotifier,
              builder: (context, userData, child) => Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ImageWidget(
                      image: userData!.user!.image!,
                      borderRadius: 30,
                      width: 25,
                      height: 40,
                      is_BoxShadow: false,
                      color: MyColors.primaryColor.withOpacity(0.1),
                    ),
                  ),
                  Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              SubHeadingText(
                                 'Welcome,',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          SubHeadingText(
                             userData.user!.name!,
                            fontSize: 15,
                            color: MyColors.primaryColor,
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
          const Divider(),
          const Spacer(),
          Consumer<AuthProvider>(builder: (context, authProvider, child) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: RoundEdgedButton(
                text: 'Logout',
                width: 150,
                onTap: () async {
                  bool? result = await showCommonAlertDailog(context,imageUrl: MyImagesUrl.alertIcon,headingText: "Are you sure?",message: "You want to logout from the app.",confirmButtonText: "Yes",cancelButtonText: "No");
                  if (result == true) {
                    authProvider.logout(context);
                  }
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
