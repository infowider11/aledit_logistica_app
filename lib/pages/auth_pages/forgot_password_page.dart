import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/constants/image_urls.dart';
import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/functions/validation_functions.dart';
import 'package:aledit_logistica/providers/auth_provider.dart';
import 'package:aledit_logistica/widgets/custom_text.dart';
import 'package:aledit_logistica/widgets/input_text_field_widget.dart';
import 'package:aledit_logistica/widgets/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  ValueNotifier<bool> pageLoading = ValueNotifier(false);

  final forgotPassFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Image.asset(
                MyImagesUrl.loginScreenLogo,
                height: 150,
                width: 150,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: forgotPassFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ParagraphText(
                      "Forgot Password",
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: MyColors.blackColor,
                    ),
                    vSizedBox05,
                    const ParagraphText(
                      "Please enter your registered email id",
                      fontSize: 14,
                      color: MyColors.blackColor,
                    ),
                    vSizedBox,
                    CustomTextField(
                      controller: emailAddress,
                      obscureText: false,
                      hintText: "Enter Email",
                      validator: ValidationFunction.emailValidation,
                      textInputType: TextInputType.emailAddress,
                    ),
                    vSizedBox2,
                    Consumer<AuthProvider>(
                        builder: (context, authPovider, child) {
                      return ValueListenableBuilder(
                          valueListenable: pageLoading,
                          builder: (context, pageLoadingValue, child) {
                            return RoundEdgedButton(
                              text: "Submit",
                              load: pageLoadingValue,
                              onTap: () {
                                pageLoading.value = true;
                                if (forgotPassFormKey.currentState!
                                    .validate()) {
                                  authPovider.forgetPassword(context,
                                      email: emailAddress.text,
                                      load: pageLoading);
                                }
                              },
                            );
                          });
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
