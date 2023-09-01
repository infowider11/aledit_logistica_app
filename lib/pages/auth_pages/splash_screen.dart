import 'package:aledit_logistica/constants/image_urls.dart';
import 'package:aledit_logistica/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthProvider auth;
  @override
  void initState() {
    super.initState();
    //
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      auth = Provider.of<AuthProvider>(context, listen: false);
      // auth.splashTimer(context);
      auth.splashAuthentication(context);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          MyImagesUrl.splashScreenLogo,
          height: 170,
          width: 170,
        ),
      ),
    );
  }
}
