import 'package:aledit_logistica/constants/static_json.dart';
import 'package:aledit_logistica/functions/navigation_functions.dart';
import 'package:aledit_logistica/functions/print_function.dart';
import 'package:aledit_logistica/modals/user_modal.dart';
import 'package:aledit_logistica/pages/auth_pages/login_page.dart';
import 'package:aledit_logistica/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/global_data.dart';
import 'dart:convert' as convert;

class AuthProvider with ChangeNotifier {


  // splashTimer(context) {
  //   Future.delayed(const Duration(seconds: 3), () async {
  //     print("timer Run");
  //     pushReplacement(
  //       context: context,
  //       screen: const LoginPage(),
  //     );
  //   });
  // }


  splashAuthentication(BuildContext context)async{
    await initializeSharedPreference();
     await isLoggedIn();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(userDataNotifier.value==null){
        pushReplacement(context: context, screen: const LoginPage());
      }else{
        pushReplacement(context: context, screen: const HomePage());
      }
    });

  }


  initializeSharedPreference()async{
    myCustomPrintStatement('initializing shared preferencess');
    sharedPreference = await SharedPreferences.getInstance();
  }
  Future<UserModal?> isLoggedIn()async{

    String? userDataString =sharedPreference.getString('userData');
    if(userDataString!=null){
      Map<String, dynamic> userData = convert.jsonDecode(userDataString);
      userDataNotifier.value = UserModal.fromJson(userData);
      return userDataNotifier.value;
    }
  }

  forgetPassword(context){
    popPage(context: context);
  }

  loginFunction(context, {required String email,required String password}) {
    userDataNotifier.value = UserModal.fromJson(staticUserData);
    updateUserDataInSharedPreference(userData: staticUserData);
    pushAndReplace(context: context, screen: const HomePage());


  }


  logout(BuildContext context)async{
    sharedPreference.clear();
    pushAndReplace(context: context, screen: LoginPage());
  }



  updateUserDataInSharedPreference({required Map userData}){
    String userDataString = convert.jsonEncode(userData);
    sharedPreference.setString('userData', userDataString);
  }
}
