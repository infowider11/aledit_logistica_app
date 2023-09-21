import 'package:aledit_logistica/functions/navigation_functions.dart';
import 'package:aledit_logistica/functions/print_function.dart';
import 'package:aledit_logistica/modals/user_modal.dart';
import 'package:aledit_logistica/pages/auth_pages/login_page.dart';
import 'package:aledit_logistica/pages/home_page.dart';
import 'package:aledit_logistica/services/api_url.dart';
import 'package:aledit_logistica/services/webservices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/global_data.dart';
import 'dart:convert' as convert;

class AuthProvider with ChangeNotifier {
  splashAuthentication(BuildContext context) async {
    await initializeSharedPreference();
    await isLoggedIn();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (userDataNotifier.value == null) {
        pushReplacement(context: context, screen: const LoginPage());
      } else {
        pushReplacement(context: context, screen: const HomePage());
      }
    });
  }

  initializeSharedPreference() async {
    myCustomPrintStatement('initializing shared preferencess');
    sharedPreference = await SharedPreferences.getInstance();
  }

  Future<UserModal?> isLoggedIn() async {
    String? userDataString = sharedPreference.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = convert.jsonDecode(userDataString);
      userDataNotifier.value = UserModal.fromJson(userData);

      var getUserResponse = Webservices.postData(
          apiUrl: ApiUrls.getUserByIdUrl,
          request: {'user_id': userData['user']['id']}).then((value) {
        if (value['status'] == 1) {
          userDataNotifier.value = UserModal.fromJson(value['data']);
          updateUserDataInSharedPreference(userData: value['data']);
          return userDataNotifier.value;
        }
      });
      userDataNotifier.notifyListeners();
      return userDataNotifier.value;
    }
  }

  forgetPassword(context,
      {required String email, required ValueNotifier load}) async {
    var request = {
      'email': email,
    };

    var forgotPassResponse = await Webservices.postData(
        apiUrl: ApiUrls.forgetPasswordUrl,
        request: request,
        showSuccessMessage: true);
    if (forgotPassResponse['status'] == 1) {
      popPage(context: context);
    }
    load.value = false;
  }

  loginFunction(context,
      {required String email,
      required String password,
      required ValueNotifier load}) async {
    var request = {
      'email': email,
      'password': password,
    };

    var loginResponse =
        await Webservices.postData(apiUrl: ApiUrls.loginUrl, request: request);
    if (loginResponse['status'] == 1) {
      userDataNotifier.value = UserModal.fromJson(loginResponse['data']);
      updateUserDataInSharedPreference(userData: loginResponse['data']);
      pushAndRemoveUntil(context: context, screen: const HomePage());
    }
    load.value = false;
  }

  logout(BuildContext context) async {
    sharedPreference.clear();
    pushAndRemoveUntil(context: context, screen: const LoginPage());
  }

  updateUserDataInSharedPreference({required Map userData}) {
    String userDataString = convert.jsonEncode(userData);
    sharedPreference.setString('userData', userDataString);
  }
}
