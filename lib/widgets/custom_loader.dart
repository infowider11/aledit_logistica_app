import 'package:aledit_logistica/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;

class CustomLoader extends StatelessWidget {
  final Color? color;
  const CustomLoader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: CircularProgressIndicator(
    //     color:color?? MyColors.primaryColor,
    //   ),
    // );
    return Center(
        child: cupertino.CupertinoActivityIndicator(
          color: color ?? MyColors.primaryColor,
        ));
    // return cupertino.CupertinoActivityIndicator
  }
}
