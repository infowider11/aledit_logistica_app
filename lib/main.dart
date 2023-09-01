import 'package:aledit_logistica/constants/global_keys.dart';
import 'package:aledit_logistica/pages/auth_pages/splash_screen.dart';
import 'package:aledit_logistica/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(),
      ),
      ],
      child: MaterialApp(
        title: 'Aledit Logistica',
        navigatorKey: MyGlobalKeys.navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
