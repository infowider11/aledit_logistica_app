import 'dart:convert';

import 'package:aledit_logistica/constants/global_data.dart';
import 'package:aledit_logistica/functions/navigation_functions.dart';
import 'package:aledit_logistica/modals/order_detail_modal.dart';
import 'package:aledit_logistica/modals/order_list_model.dart';
import 'package:aledit_logistica/pages/order_detail_page.dart';
import 'package:aledit_logistica/services/api_url.dart';
import 'package:aledit_logistica/services/webservices.dart';
import 'package:aledit_logistica/widgets/common_alert_dailog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {

 getOrderList(context, {required ValueNotifier load}) async{
  load.value = true;
  load.notifyListeners();
      var request = {
      'user_id': userDataNotifier.value!.user!.id
    };

    var orderListResponse = await Webservices.postData(
      apiUrl: ApiUrls.getOrderListUrl,
      request: request,
    );
    load.value = false;
      load.notifyListeners();
    return  OrderListModal.fromJson(orderListResponse['data']);
  }

  getOrderDetail(context,
      {required String orderId,  ValueNotifier? load}) async {
        load!.value = true;
    var request = {
      'order_id': orderId,
      'user_id': userDataNotifier.value!.user!.id
    };

    var orderDetailResponse = await Webservices.postData(
      apiUrl: ApiUrls.getOrderDetailUrl,
      request: request,
    );
    if (orderDetailResponse['status'] == 1) {
      OrderDetailModal.fromJson(orderDetailResponse['data']);
      push(
        context: context,
        screen: OrderDetailPage(
            orderDetailModal:
                OrderDetailModal.fromJson(orderDetailResponse['data'])),
      );
    }
    load.value = false;
  }

  addBox(context,
      {required ValueNotifier<OrderDetailModal> orderDetailData,
      required TextEditingController noOfBoxesController,
      required ValueNotifier shippingStoreSelected}) async {
    var currentDate = DateTime.now();
    String formatedString = currentDate
        .toString()
        .replaceAll(RegExp(r'[-: ]'), '')
        .split(".")
        .first
        .substring(2);

    for (int i = 0;
        i <
            int.parse(noOfBoxesController.text.isEmpty
                ? '1'
                : noOfBoxesController.text);
        i++) {
      var lastLength = orderDetailData.value.boxes!.isNotEmpty
          ? (int.parse(orderDetailData.value
                  .boxes![orderDetailData.value.boxes!.length - 1].boxBarcode!
                  .split("-")
                  .last) +
              1)
          : null;
      orderDetailData.value.boxes!.add(
        Boxes(
          addressComments: TextEditingController(),
          addressId: shippingStoreSelected.value['address_id'],
          addressTitle: shippingStoreSelected.value['title'],
          products: [],
          boxBarcode: orderDetailData.value.boxes!.isEmpty
              ? "$formatedString-1"
              : "${orderDetailData.value.boxes![orderDetailData.value.boxes!.length - 1].boxBarcode!.split("-").first}-$lastLength",
        ),
      );
    }
    orderDetailData.notifyListeners();
    showCommonAlertDailog(
      context,
      headingText: "Successfully Added",
    );
  }

  deleteBox(context,
      {required ValueNotifier<OrderDetailModal> orderDetailData,
      required int index,
      required ValueNotifier<bool> loading}) async {
    loading.value = true;
    loading.notifyListeners();
    var request = {
      'order_id': orderDetailData.value.orderdata!.id,
      'address_id': orderDetailData.value.boxes![index].addressId,
      'box_barcode': orderDetailData.value.boxes![index].boxBarcode,
    };
    var deleteBoxResponse = await Webservices.postData(
        apiUrl: ApiUrls.deleteBoxUrl,
        request: request,
        showSuccessMessage: true);
    if (deleteBoxResponse['status'] == 1) {
      popPage(context: context);
      orderDetailData.value.boxes!.removeAt(index);
    }
    loading.value = false;
    orderDetailData.notifyListeners();
  }

  deleteProductFromBox(context,
      {required ValueNotifier<OrderDetailModal> orderDetailData,
      required int index,
      required int productIndex,
      required ValueNotifier<bool> loading}) async {
    loading.value = true;
    loading.notifyListeners();
    var request = {
      'order_id': orderDetailData.value.orderdata!.id,
      'address_id': orderDetailData.value.boxes![index].addressId,
      'box_barcode': orderDetailData.value.boxes![index].boxBarcode,
      'product_id':
          orderDetailData.value.boxes![index].products![productIndex].productId,
    };
    var deleteProductResponse = await Webservices.postData(
        apiUrl: ApiUrls.deleteProductUrl,
        request: request,
        showSuccessMessage: true);
    if (deleteProductResponse['status'] == 1) {
      popPage(context: context);
      orderDetailData.value.boxes![index].products!.removeAt(productIndex);
    }
    loading.value = false;
    orderDetailData.notifyListeners();
  }

  saveOrder(context,
      {required ValueNotifier<OrderDetailModal> orderDetailData,
      required ValueNotifier<bool> loading}) async {
    loading.value = true;
    loading.notifyListeners();
    bool isValidState = true;
    for (int i = 0; i < orderDetailData.value.boxes!.length; i++) {
      if (orderDetailData.value.boxes![i].products!.isEmpty) {
        isValidState = false;
        showCommonAlertDailog(context,
            successIcon: false,
            headingText: "Please add at least one product on box.");
        break;
      }
    }
    if (isValidState) {
      var request = {
        'order_id': orderDetailData.value.orderdata!.id,
        'boxdata': jsonEncode(
            orderDetailData.value.boxes!.map((e) => e.toJson()).toList())
      };
      print("Request is that $request");
      var saveOrderResponse = await Webservices.postData(
          apiUrl: ApiUrls.saveOrderUrl,
          request: request,
          showSuccessMessage: true);
      if (saveOrderResponse['status'] == 1) {
        popPage(context: context);
      }
    }
    loading.value = false;
    orderDetailData.notifyListeners();
  }

  scanProduct(context,
      {required ValueNotifier<OrderDetailModal> orderDetailData,
      required int index,
      required String productBarcode,
      required ValueNotifier<bool> loading}) async {
    loading.value = true;
    loading.notifyListeners();
    var request = {
      'order_id': orderDetailData.value.orderdata!.id,
      'address_id': orderDetailData.value.boxes![index].addressId,
      'product_barcode': productBarcode,
    };
    var scanProductResponse = await Webservices.postData(
        apiUrl: ApiUrls.scanProductUrl,
        request: request,
        showSuccessMessage: false);
    int scannedQty = 0;
    if (scanProductResponse['status'] == 1) {
      for (int a = 0; a < orderDetailData.value.boxes!.length; a++) {
        if (orderDetailData.value.boxes![index].addressId ==
            orderDetailData.value.boxes![a].addressId) {
          for (int b = 0;
              b < orderDetailData.value.boxes![a].products!.length;
              b++) {
            if (orderDetailData.value.boxes![a].products![b].productId ==
                scanProductResponse['data']['product_id']) {
              scannedQty = scannedQty +
                  orderDetailData.value.boxes![a].products![b].scannedQty!;
            }
          }
        }
      }
      if (scannedQty < scanProductResponse['data']['total_quantity']) {
        int indexOfProduct = orderDetailData.value.boxes![index].products!
            .indexWhere((element) =>
                element.productId == scanProductResponse['data']['product_id']);
        print(
            "Scanned Quanty $scannedQty index of product Quantity $indexOfProduct");
        if (indexOfProduct == -1) {
          orderDetailData.value.boxes![index].products!.add(
            Products(
              scannedQty: 1,
              boxBarcode: orderDetailData.value.boxes![index].boxBarcode,
              productId: scanProductResponse['data']['product_id'],
              orderDetailId: scanProductResponse['data']['order_detail_id'],
              totalQuantity: scanProductResponse['data']['total_quantity'],
              productBarcode: scanProductResponse['data']['product_barcode'],
              sku: scanProductResponse['data']['sku'],
              productImage: scanProductResponse['data']['image'],
              productName: scanProductResponse['data']['name'],
              reference: scanProductResponse['data']['reference'],
            ),
          );
        } else {
          orderDetailData.value.boxes![index].products![indexOfProduct]
              .scannedQty = orderDetailData
                  .value.boxes![index].products![indexOfProduct].scannedQty! +
              1;
        }
      } else {
        showCommonAlertDailog(context,
            successIcon: false,
            headingText: 'No more product quantity available');
      }
    }
    loading.value = false;
    orderDetailData.notifyListeners();
  }

// List<OrderModal> _orders = [];
  //
  // List<OrderModal> get orders => _orders;
  //
  //
  // OrderProvider(this._orders);
  //
  // void addOrder(OrderModal order) {
  //   _orders.add(order);
  //   notifyListeners();
  // }

// Implement other methods like update and delete as needed.
}
