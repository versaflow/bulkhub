import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'variant_items_model.dart';

class ProductVariantModel extends Equatable {
  final int id;
  final int productId;
  final String name;
  final int status;
  final String createdAt;
  final String updatedAt;
  final List<VariantItemModel> variantItems;
  const ProductVariantModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.variantItems,
  });

  ProductVariantModel copyWith({
    int? id,
    int? productId,
    String? name,
    int? status,
    String? createdAt,
    String? updatedAt,
    List<VariantItemModel>? variantItems,
  }) {
    return ProductVariantModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      variantItems: variantItems ?? this.variantItems,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'product_id': productId});
    result.addAll({'name': name});
    result.addAll({'status': status});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    result
        .addAll({'variant_items': variantItems.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ProductVariantModel.fromMap(Map<String, dynamic> map) {
    return ProductVariantModel(
      id: map['id']?.toInt() ?? 0,
      productId: map['product_id'] ?? 0,
      name: map['name'] ?? '',
      status: map['status'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      variantItems: map['variant_items'] != null
          ? List<VariantItemModel>.from(
              map['variant_items']?.map((x) => VariantItemModel.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductVariantModel.fromJson(String source) =>
      ProductVariantModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductVariantModel(id: $id, product_id: $productId, name: $name, status: $status, created_at: $createdAt, updated_at: $updatedAt, variant_items: $variantItems)';
  }

  @override
  List<Object> get props {
    return [
      id,
      productId,
      name,
      status,
      createdAt,
      updatedAt,
      variantItems,
    ];
  }
}
