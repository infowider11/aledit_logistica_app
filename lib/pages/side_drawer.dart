import 'package:aledit_logistica/providers/auth_provider.dart';
import 'package:aledit_logistica/widgets/confirmation_dialog.dart';
import 'package:aledit_logistica/widgets/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSideDrawer extends StatelessWidget {
  const CustomSideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white.withOpacity(0.9),
      width: MediaQuery.of(context).size.width-100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return RoundEdgedButton(text: 'Logout', width: 150,onTap: ()async{
                bool? result = await showCustomConfirmationDialog();
                if(result==true){
                  authProvider.logout(context);
                }
              },);
            }
          )
        ],
      ),
    );
  }
}
