import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/constants/global_data.dart';
import 'package:aledit_logistica/constants/image_urls.dart';
import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/functions/navigation_functions.dart';
import 'package:aledit_logistica/functions/validation_functions.dart';
import 'package:aledit_logistica/modals/order_modal.dart';
import 'package:aledit_logistica/pages/qr_scaner.dart';
import 'package:aledit_logistica/widgets/common_alert_dailog.dart';
import 'package:aledit_logistica/widgets/custom_appbar.dart';
import 'package:aledit_logistica/widgets/custom_circular_image.dart';
import 'package:aledit_logistica/widgets/custom_rich_text.dart';
import 'package:aledit_logistica/widgets/custom_text.dart';
import 'package:aledit_logistica/widgets/fully_custom_dropdown.dart';
import 'package:aledit_logistica/widgets/input_text_field_widget.dart';
import 'package:aledit_logistica/widgets/round_edged_button.dart';
import 'package:flutter/material.dart';

import '../modals/user_modal.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderDetailModal orderDetailModal;
  const OrderDetailPage({Key? key, required this.orderDetailModal})
      : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  TextEditingController noOfBoxesController = TextEditingController();
  ValueNotifier shippingStoreSelectedValue = ValueNotifier(null);
  ValueNotifier shippingAddress = ValueNotifier([]);
  ValueNotifier<OrderDetailModal> orderDetailData =
      ValueNotifier<OrderDetailModal>(OrderDetailModal.fromJson({}));
  final addBoxesFormKey = GlobalKey<FormState>();
  Map? shipping;
  @override
  void initState() {
    shippingAddress.value = widget.orderDetailModal.shippingaddress!
        .map((e) => e.toJson())
        .toList();
    orderDetailData.value = widget.orderDetailModal;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context, title: 'Order Detail'),
        body: ValueListenableBuilder<OrderDetailModal?>(
            valueListenable: orderDetailData,
            builder: (context, orderDetailDataNotifier, child) {
              return Padding(
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
                                CustomCircularImage(
                                    imageUrl: userData!.user!.image ?? ''),
                                hSizedBox05,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SubHeadingText(
                                        '${userData.user!.name}',
                                      ),
                                      vSizedBox05,
                                      Container(
                                        decoration: BoxDecoration(
                                            color: MyColors.textFeildFillColor,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        padding: const EdgeInsets.all(4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const ParagraphText(
                                              'Order ID:',
                                              color: Colors.black45,
                                            ),
                                            Flexible(
                                                child: ParagraphText(
                                              orderDetailDataNotifier!
                                                      .orderdata!.orderId ??
                                                  '',
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
                                      color: const Color(0xFFFDBF47),
                                      borderRadius: BorderRadius.circular(4)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: ParagraphText(
                                    orderDetailDataNotifier.orderdata!.status ??
                                        'In Process',
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            );
                          }),
                      vSizedBox2,
                      if (orderDetailDataNotifier!.orderdata!.speicalNotes !=
                          null)
                        ParagraphText(
                            orderDetailDataNotifier.orderdata!.speicalNotes ??
                                ''),
                      orderDetailDataNotifier.orderdata!.speicalNotes == null
                          ? Container()
                          : vSizedBox2,
                      Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(),
                        ], color: Colors.white),
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: addBoxesFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: shippingStoreSelectedValue,
                                  builder: (context,
                                      shippingStoreSelectedValueNotifier,
                                      child) {
                                    return CustomDropDownFeild(
                                        validator: (value) {
                                          return ValidationFunction
                                              .requiredValidation(value,
                                                  msg:
                                                      "Please select shipping address");
                                        },
                                        onChanged: (val) {
                                          print(val);
                                          shippingStoreSelectedValue.value =
                                              val;
                                        },
                                        selectedValue:
                                            shippingStoreSelectedValueNotifier,
                                        headingText: 'Select Shipping Store',
                                        popUpTextKey: 'title',
                                        valueKey: 'address_id',
                                        itemsList: shippingAddress.value,
                                        hintText: 'Select Shipping Store');
                                  }),
                              vSizedBox,
                              const SubHeadingText('No Of Boxes:'),
                              vSizedBox,
                              CustomTextField(
                                controller: noOfBoxesController,
                                hintText: 'Enter No Of Boxes Here',
                                textInputType: TextInputType.number,
                              ),
                              vSizedBox2,
                              ValueListenableBuilder(
                                valueListenable: shippingStoreSelectedValue,
                                builder: (context,
                                    shippingStoreSelectedValueNotifier, child) {
                                  return RoundEdgedButton(
                                    text: 'Go',
                                    onTap: () {
                                      if (addBoxesFormKey.currentState!
                                          .validate()) {
                                        for (int i = 0;
                                            i <
                                                int.parse(noOfBoxesController
                                                        .text.isEmpty
                                                    ? '1'
                                                    : noOfBoxesController.text);
                                            i++) {
                                          orderDetailData.value.boxes!.add(
                                            Boxes(
                                                addressComments:
                                                    TextEditingController(),
                                                addressId:
                                                    shippingStoreSelectedValueNotifier[
                                                        'address_id'],
                                                addressTitle:
                                                    shippingStoreSelectedValueNotifier[
                                                        'title'],
                                                products: [],
                                                boxBarcode: '230714143957-'
                                                    '${orderDetailDataNotifier.boxes!.isEmpty ? '1' : orderDetailDataNotifier.boxes!.length + 1}'),
                                          );
                                        }
                                          orderDetailData.notifyListeners();
                                          showCommonAlertDailog(
                                            context,
                                            headingText: "Successfully Added",
                                          );
                                          shippingStoreSelectedValue.value = null;
                                          noOfBoxesController.clear();
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      vSizedBox05,
                      for (int i = 0;
                          i < orderDetailDataNotifier.boxes!.length;
                          i++)
                        Container(
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(),
                            ], color: Colors.white),
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SubHeadingText('Shipping Store'),
                                vSizedBox,
                                Container(
                                  decoration: BoxDecoration(
                                    color: MyColors.textFeildFillColor,
                                    borderRadius: BorderRadius.circular(
                                        globalBoxBorderRadius),
                                  ),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: ParagraphText(
                                    orderDetailDataNotifier
                                            .boxes![i].addressTitle ??
                                        '',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                vSizedBox2,
                                Container(
                                    decoration: BoxDecoration(
                                      color: MyColors.textFeildFillColor,
                                      borderRadius: BorderRadius.circular(
                                          globalBoxBorderRadius),
                                    ),
                                    margin: const EdgeInsets.only(bottom: 16),
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: SubHeadingText(
                                                    'Box barcode :  ${orderDetailDataNotifier.boxes![i].boxBarcode ?? ''}')),
                                            InkWell(
                                              onTap: () {},
                                              child: Image.asset(
                                                  MyImagesUrl.deleteIcon),
                                            ),
                                            hSizedBox,
                                            InkWell(
                                              onTap: () {
                                                push(
                                                    context: context,
                                                    screen: const QRScaner());
                                              },
                                              child: Image.asset(
                                                MyImagesUrl.qrScanIcon,
                                                height: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                        vSizedBox2,
                                        if (orderDetailDataNotifier
                                            .boxes![i].products!.isEmpty)
                                          CustomTextField(
                                            controller: TextEditingController(),
                                            hintText: 'Scan now',
                                            backgroundColor: Colors.white,
                                          ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: orderDetailDataNotifier
                                              .boxes![i].products!.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              // decoration:
                                              //     const BoxDecoration(boxShadow: [
                                              //   BoxShadow(),
                                              // ],
                                              color: Colors.white,
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  CustomCircularImage(
                                                    fileType:
                                                        CustomFileType.network,
                                                    imageUrl: widget
                                                            .orderDetailModal
                                                            .boxes![i]
                                                            .products![index]
                                                            .productImage ??
                                                        '',
                                                    height: 50,
                                                    width: 50,
                                                    borderRadius: 2,
                                                  ),
                                                  hSizedBox,
                                                  Expanded(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      RichTextCustomWidget(
                                                          firstText:
                                                              '${orderDetailDataNotifier.boxes![i].products![index].productName} - ',
                                                          firstTextFontSize: 14,
                                                          firstTextFontweight:
                                                              FontWeight.normal,
                                                          secondText:
                                                              '${orderDetailDataNotifier.boxes![i].products![index].totalQuantity} (${orderDetailDataNotifier.boxes![i].products![index].scannedQty})'),
                                                      vSizedBox02,
                                                      ParagraphText(
                                                        widget
                                                                .orderDetailModal
                                                                .boxes![i]
                                                                .products![
                                                                    index]
                                                                .productBarcode ??
                                                            "",
                                                        fontSize: 12,
                                                      )
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        vSizedBox2,
                                        CustomTextField(
                                          controller: orderDetailDataNotifier
                                              .boxes![i].addressComments!,
                                          hintText: 'If any Comment',
                                          backgroundColor: Colors.white,
                                          maxLines: 3,
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      RoundEdgedButton(
                        text: 'Process',
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  elevation: 0,
                                  child: Container(
                                    height: 400,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // vSizedBox2,
                                        Image.asset(MyImagesUrl.qrSampleImage),
                                        vSizedBox2,
                                        const RoundEdgedButton(
                                          text: 'Scan',
                                          width: 200,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
