import 'package:flutter/material.dart';


class OrderDetailModal {
  Orderdata? orderdata;
  List<Shippingaddress>? shippingaddress;
  List<Boxes>? boxes;

  OrderDetailModal({this.orderdata, this.shippingaddress, this.boxes});

  OrderDetailModal.fromJson(Map<String, dynamic> json) {
    orderdata = json['orderdata'] != null
        ? Orderdata.fromJson(json['orderdata'])
        : null;
    if (json['shippingaddress'] != null) {
      shippingaddress = <Shippingaddress>[];
      json['shippingaddress'].forEach((v) {
        shippingaddress!.add(Shippingaddress.fromJson(v));
      });
    }
    if (json['boxes'] != null) {
      boxes = <Boxes>[];
      json['boxes'].forEach((v) {
        boxes!.add(Boxes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderdata != null) {
      data['orderdata'] = orderdata!.toJson();
    }
    if (shippingaddress != null) {
      data['shippingaddress'] =
          shippingaddress!.map((v) => v.toJson()).toList();
    }
    if (boxes != null) {
      data['boxes'] = boxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orderdata {
  int? id;
  String? orderId;
  String? status;
  String? speicalNotes;
  String? cname;
  int? cid;

  Orderdata(
      {this.id,
      this.orderId,
      this.status,
      this.speicalNotes,
      this.cname,
      this.cid});

  Orderdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    status = json['status'];
    speicalNotes = json['special_notes'] ?? '';
    cname = json['cname'];
    cid = json['cid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['status'] = status;
    data['special_notes'] = speicalNotes;
    data['cname'] = cname;
    data['cid'] = cid;
    return data;
  }
}

class Shippingaddress {
  int? addressId;
  String? title;
  int? addressBarcode;

  Shippingaddress({this.addressId, this.title, this.addressBarcode});

  Shippingaddress.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    title = json['title'];
    addressBarcode = json['address_barcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['title'] = title;
    data['address_barcode'] = addressBarcode;
    return data;
  }
}

class Boxes {
  String? boxBarcode;
  String? addressTitle;
  int? addressId;
  int? noOfBoxes;
  TextEditingController? addressComments;
  List<Products>? products;

  Boxes(
      {this.boxBarcode,
      this.addressId,
      this.addressTitle,
      this.noOfBoxes,
      this.addressComments,
      this.products});

  Boxes.fromJson(Map<String, dynamic> json) {
    boxBarcode = json['box_barcode'];
    addressTitle = json['address_title'];
    addressId = json['address_id'];
    noOfBoxes = json['no_of_boxes'];
    addressComments = json['address_comments'] != null
        ? TextEditingController(text: json['address_comments'])
        : TextEditingController();
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['box_barcode'] = boxBarcode;
    data['address_title'] = addressTitle;
    data['address_id'] = addressId;
    data['no_of_boxes'] = noOfBoxes??1;
    data['address_comments'] = addressComments!.text;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  int? orderDetailId;
  String? boxBarcode;
  int? scannedQty;
  int? productId;
  String? productBarcode;
  String? productName;
  String? productImage;
  String? reference;
  String? sku;
  int? totalQuantity;

  Products(
      {this.id,
      this.orderDetailId,
      this.boxBarcode,
      this.scannedQty,
      this.productId,
      this.productBarcode,
      this.productName,
      this.productImage,
      this.reference,
      this.sku,
      this.totalQuantity});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDetailId = json['order_detail_id'];
    boxBarcode = json['box_barcode'];
    scannedQty = json['scanned_qty'];
    productId = json['product_id'];
    productBarcode = json['product_barcode'];
    productName = json['product_name'];
    productImage = json['image'];
    reference = json['reference'];
    sku = json['sku'];
    totalQuantity = json['total_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_detail_id'] = orderDetailId;
    data['box_barcode'] = boxBarcode;
    data['scanned_qty'] = scannedQty;
    data['product_id'] = productId;
    data['product_barcode'] = productBarcode;
    data['product_name'] = productImage;
    data['reference'] = reference;
    data['sku'] = sku;
    data['total_quantity'] = totalQuantity;
    return data;
  }
}
