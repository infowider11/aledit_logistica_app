import 'package:flutter/material.dart';
import '../functions/navigation_functions.dart';
import 'custom_text.dart';

AppBar customAppBar(BuildContext context, {String title = '',List<Widget>? actions}){
  return AppBar(
    leading: InkWell(
      onTap: () async {
        popPage(context: context);
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),
        child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,),
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: AppBarHeadingText(
      text: title,
      color: Colors.black,
    ),
    actions: actions,
  );
}