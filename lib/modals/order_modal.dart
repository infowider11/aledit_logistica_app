class OrderModal {
  int id;
  int status;
  String customerOrderId;
  String specialNotes;
  String customerName;
  String addresstitles;

  OrderModal(
      {required this.id,
      required this.status,
      required this.customerOrderId,
      required this.specialNotes,
      required this.customerName,
      required this.addresstitles});

  factory OrderModal.fromJson(Map orderJson) {
    return OrderModal(
      id: orderJson['id'],
      status: orderJson['status'],
      customerOrderId: orderJson['customer_order_id'],
      specialNotes: orderJson['special_notes'] ?? '',
      customerName: orderJson['customer_name'],
      addresstitles: orderJson['addresstitles'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['customer_order_id'] = customerOrderId;
    data['special_notes'] = specialNotes;
    data['customer_name'] = customerName;
    data['addresstitles'] = addresstitles;

    return data;
  }
}

