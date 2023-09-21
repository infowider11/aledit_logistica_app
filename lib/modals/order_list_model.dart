import 'package:aledit_logistica/modals/order_modal.dart';

class OrderListModal {
  List<OrderModal> pending;
  List<OrderModal> inprocess;
  List<OrderModal> shipping;
  List<OrderModal> shipped;

  OrderListModal({
    required this.pending,
    required this.inprocess,
    required this.shipping,
    required this.shipped,
  });

  factory OrderListModal.fromJson(Map data) {
    return OrderListModal(
      pending: List.generate(data['pending'] ==null?0: data['pending'].length,
          (index) => OrderModal.fromJson(data['pending'][index])),
      inprocess: List.generate(data['inprocess'] ==null?0:data['inprocess'].length,
          (index) => OrderModal.fromJson(data['inprocess'][index])),
      shipping: List.generate(data['shipping'] ==null?0 :data['shipping'].length,
          (index) => OrderModal.fromJson(data['shipping'][index])),
      shipped: List.generate(
        data['shipped'] ==null?0 :
        data['shipped'].length,
        (index) => OrderModal.fromJson(
          data['shipped'][index],
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['pending'] = pending.map((v) => v.toJson()).toList();

    data['inprocess'] = inprocess.map((v) => v.toJson()).toList();

    data['shipping'] = shipping.map((v) => v.toJson()).toList();

    data['shipped'] = shipped.map((v) => v.toJson()).toList();

    return data;
  }
}
