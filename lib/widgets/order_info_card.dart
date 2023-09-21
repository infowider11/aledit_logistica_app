import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/modals/order_modal.dart';
import 'package:aledit_logistica/providers/order_provider.dart';
import 'package:aledit_logistica/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderInfoCard extends StatelessWidget {
  final OrderModal orderData;
  final ValueNotifier<bool>? orderListPageLoader;
  const OrderInfoCard({super.key, required this.orderData,this.orderListPageLoader});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (orderData.status == 0 || orderData.status == 1) {
          OrderProvider orderProvider =
              Provider.of<OrderProvider>(context, listen: false);
          orderProvider.getOrderDetail(context,
              orderId: orderData.customerOrderId,load: orderListPageLoader);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: MyColors.whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                  color: MyColors.lightgrey,
                  blurRadius: 5.0,
                  spreadRadius: 1,
                  offset: Offset(0, 0))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubHeadingText(
                  "Customer Order ID :- ${orderData.customerOrderId}",
                  color: MyColors.blackColor,
                  fontSize: 14,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFFDBF47),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ParagraphText(
                    orderData.status == 0
                        ? 'Pending'
                        : orderData.status == 1
                            ? 'In Process'
                            : orderData.status == 2
                                ? 'Shipping'
                                : 'Shipped',
                    color: Colors.white,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            vSizedBox05,
            SubHeadingText(
              "Customer Name :- ${orderData.customerName}",
              color: MyColors.blackColor,
              fontSize: 14,
            ),
            vSizedBox05,
            Row(
              children: [
                const Icon(Icons.location_on,
                    color: MyColors.primaryColor, size: 20),
                hSizedBox05,
                Expanded(
                  child: SubHeadingText(
                    orderData.addresstitles,
                    color: MyColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            vSizedBox05,
            if (orderData.specialNotes.isNotEmpty)
              const SubHeadingText(
                "Special Note :- ",
                color: MyColors.primaryColor,
                fontSize: 14,
              ),
            if (orderData.specialNotes.isNotEmpty) vSizedBox05,
            if (orderData.specialNotes.isNotEmpty)
              SubHeadingText(
                orderData.specialNotes,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
          ],
        ),
      ),
    );
  }
}
