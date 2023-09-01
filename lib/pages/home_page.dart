import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/constants/image_urls.dart';
import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/functions/navigation_functions.dart';
import 'package:aledit_logistica/modals/order_modal.dart';
import 'package:aledit_logistica/pages/order_detail_page.dart';
import 'package:aledit_logistica/pages/side_drawer.dart';
import 'package:aledit_logistica/widgets/custom_text.dart';
import 'package:aledit_logistica/widgets/input_text_field_widget.dart';
import 'package:aledit_logistica/widgets/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/global_data.dart';
import '../functions/validation_functions.dart';
import '../providers/order_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController orderIdController = TextEditingController();
  final orderIdFormKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: InkWell(
            onTap: () async {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
              child: Image.asset(MyImagesUrl.menuSideBar),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ValueListenableBuilder(
              valueListenable: userDataNotifier,
              builder: (context, userData, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppBarHeadingText(
                      text: 'Good Morning,',
                      color: Colors.black,
                    ),
                    Expanded(
                        child: AppBarHeadingText(
                      text: ' ${userData?.firstName}',
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ))
                  ],
                );
              }),
        ),
        drawer: CustomSideDrawer(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox2,
              Image.asset(
                MyImagesUrl.homePageStaticImage,
                width: MediaQuery.of(context).size.width,
              ),
              vSizedBox6,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Form(
                  key: orderIdFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubHeadingText('Order ID'),
                      vSizedBox05,
                      ParagraphText(
                        'Please enter your order id',
                        color: Colors.black54,
                      ),
                      vSizedBox,
                      CustomTextField(controller: orderIdController, hintText: '#53210ACD', validator: ValidationFunction.orderIdValidation,),
                      vSizedBox2,
                      RoundEdgedButton(text: 'Process', onTap: (){
                        if(orderIdFormKey.currentState!.validate()){

                          OrderModal  orderModal= OrderModal(orderId: orderIdController.text, shippingStore: '1', noOfBoxes: 3);
                          push(context: context, screen: ChangeNotifierProvider(
                            create: (context) => OrderProvider(orderModal),
                            child: OrderDetailPage(),
                          ),);
                        }
                      },),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
