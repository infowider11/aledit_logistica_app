   import 'package:aledit_logistica/modals/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<UserModal?> userDataNotifier = ValueNotifier(null);
ValueNotifier<bool> showHide = ValueNotifier(true);

// showHide.value = true;
late SharedPreferences sharedPreference;

double globalBoxBorderRadius = 6;