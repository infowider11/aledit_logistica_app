import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/constants/global_data.dart';
import 'package:aledit_logistica/constants/image_urls.dart';
import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/widgets/custom_appbar.dart';
import 'package:aledit_logistica/widgets/custom_circular_image.dart';
import 'package:aledit_logistica/widgets/custom_text.dart';
import 'package:aledit_logistica/widgets/fully_custom_dropdown.dart';
import 'package:aledit_logistica/widgets/input_text_field_widget.dart';
import 'package:aledit_logistica/widgets/round_edged_button.dart';
import 'package:flutter/material.dart';

import '../modals/user_modal.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  TextEditingController noOfBoxesController = TextEditingController();
  Map? shipping;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, title: 'Order Detail'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              vSizedBox2,
              ValueListenableBuilder<UserModal?>(
                  valueListenable: userDataNotifier,
                  builder: (context, userData, child) {
                    return Row(
                      children: [
                        CustomCircularImage(imageUrl: userData!.profileImage),
                        hSizedBox05,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubHeadingText(
                                '${userData.firstName}',
                              ),
                              vSizedBox05,
                              Container(
                                decoration: BoxDecoration(
                                    color: MyColors.textFeildFillColor,
                                    borderRadius: BorderRadius.circular(4)),
                                padding: EdgeInsets.all(4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ParagraphText(
                                      'Order ID:',
                                      color: Colors.black45,
                                    ),
                                    Flexible(
                                        child: ParagraphText(
                                      'JHGF345',
                                      fontWeight: FontWeight.w500,
                                    )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFDBF47),
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.all(4),
                          child: ParagraphText(
                            'In Process',
                            color: Colors.white,
                          ),
                        )
                      ],
                    );
                  }),
              vSizedBox2,
              ParagraphText(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.'),
              vSizedBox2,
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(),
                ], color: Colors.white),
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubHeadingText('Select Shipping'),
                    vSizedBox,
                    CustomDropDown(
                        onChanged: (val) {},
                        hint: 'Select Shipping Store',
                        selectedItem: shipping),
                    SubHeadingText('No Of Boxes:'),
                    vSizedBox,
                    CustomTextField(
                      controller: noOfBoxesController,
                      hintText: 'Enter No Of Boxes Here',
                      textInputType: TextInputType.number,
                    ),
                    vSizedBox2,
                    RoundEdgedButton(text: 'Go', onTap: (){
                      showDialog(context: context, builder: (context){
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: EdgeInsets.symmetric(horizontal: 16),
                          elevation: 0,
                          child: Container(
                            
                            height: 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // vSizedBox2,
                                Image.asset(MyImagesUrl.qrSampleImage),
                                vSizedBox2,
                                RoundEdgedButton(text: 'Scan', width: 200,),
                              ],
                            ),
                          ),
                        );
                      });
                    },),
                  ],
                ),
              ),
              vSizedBox2,
              Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(),
                  ], color: Colors.white),
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubHeadingText('Shipping Store'),
                      vSizedBox,
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.textFeildFillColor,
                          borderRadius: BorderRadius.circular(globalBoxBorderRadius),

                        ),
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: ParagraphText('Ladding Floor', fontWeight: FontWeight.w500,),
                      ),

                      vSizedBox2,
                      for(int i = 0; i<3;i++)
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.textFeildFillColor,
                            borderRadius: BorderRadius.circular(globalBoxBorderRadius),

                          ),
                          margin: EdgeInsets.only(bottom: 16),
                          width: double.infinity,
                          padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Column(
                            children: [
                              Row(

                                children: [
                                  Expanded(child: SubHeadingText('No of Boxes: ${i+1}')),
                                  Image.asset(MyImagesUrl.deleteIcon),
                                  hSizedBox,
                                  Image.asset(MyImagesUrl.qrScanIcon, height: 30,),

                                ],
                              ),
                              vSizedBox2,
                              CustomTextField(controller: TextEditingController(), hintText: 'Scan now', backgroundColor: Colors.white,),
                              vSizedBox2,
                              CustomTextField(controller: TextEditingController(), hintText: 'If any Comment', backgroundColor: Colors.white,maxLines: 3,),
                            ],
                          )
                        ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
