import 'dart:convert';

import 'package:equatable/equatable.dart';

class VariantItemModel extends Equatable {
  final int id;
  final int productVariantId;
  final String productVariantName;
  final int productId;
  final String name;
  final int price;
  final int status;
  final String createdAt;
  final String updatedAt;
  const VariantItemModel({
    required this.id,
    required this.productVariantId,
    required this.productVariantName,
    required this.productId,
    required this.name,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  VariantItemModel copyWith({
    int? id,
    int? productVariantId,
    String? productVariantName,
    int? productId,
    String? name,
    int? price,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return VariantItemModel(
      id: id ?? this.id,
      productVariantId: productVariantId ?? this.productVariantId,
      productVariantName: productVariantName ?? this.productVariantName,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'product_variant_id': productVariantId});
    result.addAll({'product_variant_name': productVariantName});
    result.addAll({'product_id': productId});
    result.addAll({'name': name});
    result.addAll({'price': price});
    result.addAll({'status': status});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});

    return result;
  }

  factory VariantItemModel.fromMap(Map<String, dynamic> map) {
    return VariantItemModel(
      id: map['id']?.toInt() ?? 0,
      productVariantId: map['product_variant_id'] ?? 0,
      productVariantName: map['product_variant_name'] ?? '',
      productId: map['product_id'] ?? 0,
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      status: map['status'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VariantItemModel.fromJson(String source) =>
      VariantItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VariantItemModel(id: $id, product_variant_id: $productVariantId, product_variant_name: $productVariantName, product_id: $productId, name: $name, price: $price, status: $status, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      productVariantId,
      productVariantName,
      productId,
      name,
      price,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
