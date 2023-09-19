import 'package:aledit_logistica/constants/global_data.dart';
import 'package:aledit_logistica/functions/navigation_functions.dart';
import 'package:aledit_logistica/modals/order_modal.dart';
import 'package:aledit_logistica/pages/order_detail_page.dart';
import 'package:aledit_logistica/services/api_url.dart';
import 'package:aledit_logistica/services/webservices.dart';
import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  getOrderDetail(context,
      {required String orderId, required ValueNotifier load}) async {
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
