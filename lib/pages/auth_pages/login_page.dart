import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/functions/navigation_functions.dart';
import 'package:aledit_logistica/functions/validation_functions.dart';
import 'package:aledit_logistica/pages/auth_pages/forgot_password_page.dart';
import 'package:aledit_logistica/widgets/custom_text.dart';
import 'package:aledit_logistica/widgets/input_text_field_widget.dart';
import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/constants/image_urls.dart';
import 'package:aledit_logistica/providers/auth_provider.dart';
import 'package:aledit_logistica/widgets/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

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
                key: loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ParagraphText(
                      "Staff Sign In",
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: MyColors.blackColor,
                    ),
                    vSizedBox05,
                    const ParagraphText(
                      "Please enter your registered email id and password",
                      fontSize: 14,
                      color: MyColors.blackColor,
                    ),
                    vSizedBox,
                    CustomTextField(
                      controller: emailController,
                      obscureText: false,
                      hintText: "Enter Email",
                      validator: ValidationFunction.emailValidation,
                      textInputType: TextInputType.emailAddress,
                    ),
                    vSizedBox2,
                    CustomTextField(
                      controller: passwordController,
                      obscureText: true,
                      hintText: "Enter Password",
                      validator: ValidationFunction.passwordValidation,
                      textInputType: TextInputType.emailAddress,
                    ),
                    vSizedBox2,
                    GestureDetector(
                      onTap: () {
                        push(
                          context: context,
                          screen: const ForgotPasswordPage(),
                        );
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: const ParagraphText(
                          "Forgot Password?",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: MyColors.blackColor,
                        ),
                      ),
                    ),
                    vSizedBox2,
                    Consumer<AuthProvider>(
                        builder: (context, authPovider, child) {
                      return RoundEdgedButton(
                        text: "Sign In",
                        onTap: () {
                          if (loginFormKey.currentState!.validate()) {
                            authPovider.loginFunction(context, email: emailController.text, password: passwordController.text);
                          }
                        },
                      );
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
