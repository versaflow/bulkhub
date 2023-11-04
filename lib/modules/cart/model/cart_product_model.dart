import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'varient_model.dart';

class CartProductModel extends Equatable {
  final int id;
  final int userId;
  final int productId;
  final String name;
  final int qty;
  final int price;
  final int tax;
  final String couponName;
  final int couponPrice;
  final int offerType;
  final String image;
  final String slug;
  final String createdAt;
  final String updatedAt;
  final List<VarientModel> variants;
  const CartProductModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.name,
    required this.qty,
    required this.price,
    required this.tax,
    required this.couponName,
    required this.couponPrice,
    required this.offerType,
    required this.image,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.variants,
  });

  CartProductModel copyWith({
    int? id,
    int? userId,
    int? productId,
    String? name,
    int? qty,
    int? price,
    int? tax,
    String? couponName,
    int? couponPrice,
    int? offerType,
    String? image,
    String? slug,
    String? createdAt,
    String? updatedAt,
    List<VarientModel>? variants,
  }) {
    return CartProductModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      tax: tax ?? this.tax,
      couponName: couponName ?? this.couponName,
      couponPrice: couponPrice ?? this.couponPrice,
      offerType: offerType ?? this.offerType,
      image: image ?? this.image,
      slug: slug ?? this.slug,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      variants: variants ?? this.variants,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'user_id': userId});
    result.addAll({'product_id': productId});
    result.addAll({'name': name});
    result.addAll({'qty': qty});
    result.addAll({'price': price});
    result.addAll({'tax': tax});
    result.addAll({'coupon_name': couponName});
    result.addAll({'coupon_price': couponPrice});
    result.addAll({'offer_type': offerType});
    result.addAll({'image': image});
    result.addAll({'slug': slug});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    result.addAll({'variants': variants.map((x) => x.toMap()).toList()});

    return result;
  }

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      id: map['id']?.toInt() ?? 0,
      userId: map['user_id'] ?? 0,
      productId: map['product_id'] ?? 0,
      name: map['name'] ?? '',
      qty: map['qty'] ?? 0,
      price: map['price'] ?? 0,
      tax: map['tax'] ?? 0,
      couponName: map['coupon_name'] ?? '',
      couponPrice: map['coupon_price'] ?? 0,
      offerType: map['offer_type'] ?? 0,
      image: map['image'] ?? '',
      slug: map['slug'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      variants: map['variants'] != null
          ? List<VarientModel>.from(
              map['variants']?.map((x) => VarientModel.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProductModel.fromJson(String source) =>
      CartProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartProductModel(id: $id, user_id: $userId, product_id: $productId, name: $name, qty: $qty, price: $price, tax: $tax, coupon_name: $couponName, coupon_price: $couponPrice, offer_type: $offerType, image: $image, slug: $slug, created_at: $createdAt, updated_at: $updatedAt, variants: $variants)';
  }

  @override
  List<Object> get props {
    return [
      id,
      userId,
      productId,
      name,
      qty,
      price,
      tax,
      couponName,
      couponPrice,
      offerType,
      image,
      slug,
      createdAt,
      updatedAt,
      variants,
    ];
  }
}
