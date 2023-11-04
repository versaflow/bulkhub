import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderedProductModel extends Equatable {
  final int id;
  final int orderId;
  final int productId;
  final int sellerId;
  final String productName;
  final int unitPrice;
  final double vat;
  final int qty;
  final String thumbImage;
  final String slug;
  final String createdAt;
  final String updatedAt;
  const OrderedProductModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.sellerId,
    required this.productName,
    required this.unitPrice,
    required this.vat,
    required this.qty,
    required this.thumbImage,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
  });

  OrderedProductModel copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? sellerId,
    String? productName,
    int? unitPrice,
    double? vat,
    int? qty,
    String? thumbImage,
    String? createdAt,
    String? updatedAt,
    String? slug,
  }) {
    return OrderedProductModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      sellerId: sellerId ?? this.sellerId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      vat: vat ?? this.vat,
      qty: qty ?? this.qty,
      thumbImage: thumbImage ?? this.thumbImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'order_id': orderId});
    result.addAll({'product_id': productId});
    result.addAll({'seller_id': sellerId});
    result.addAll({'product_name': productName});
    result.addAll({'unit_price': unitPrice});
    result.addAll({'vat': vat});
    result.addAll({'qty': qty});
    result.addAll({'thumb_image': thumbImage});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    result.addAll({'slug': slug});

    return result;
  }

  factory OrderedProductModel.fromMap(Map<String, dynamic> map) {
    return OrderedProductModel(
      id: map['id']?.toInt() ?? 0,
      orderId: map['order_id'] ?? 0,
      productId: map['product_id'] ?? 0,
      sellerId: map['seller_id'] ?? 0,
      productName: map['product_name'] ?? '',
      unitPrice: map['unit_price'] ?? 0,
      vat: map['vat']?.toDouble() ?? 0.0,
      qty: map['qty'] ?? 0,
      thumbImage: map['product']['thumb_image'] ?? '',
      slug: map['product']['slug'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderedProductModel.fromJson(String source) =>
      OrderedProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderedProductModel(id: $id, order_id: $orderId, product_id: $productId, seller_id: $sellerId, product_name: $productName, unit_price: $unitPrice, vat: $vat, qty: $qty, thumb_image: $thumbImage, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        productId,
        sellerId,
        productName,
        unitPrice,
        vat,
        qty,
        thumbImage,
        createdAt,
        updatedAt
      ];
}
