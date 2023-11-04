import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'details_product_reviews_model.dart';
import 'product_details_product_model.dart';
import 'product_variant_model.dart';

class ProductDetailsModel extends Equatable {
  final int id;
  final int totalProductReviewQty;
  final ProductDetailsProductModel product;
  final List<ProductDetailsProductModel> relatedProducts;
  final List<DetailsProductReviewModel> productReviews;
  final List<ProductVariantModel> productVariants;
  const ProductDetailsModel({
    required this.id,
    required this.totalProductReviewQty,
    required this.product,
    required this.relatedProducts,
    required this.productReviews,
    required this.productVariants,
  });

  ProductDetailsModel copyWith({
    int? id,
    int? totalProductReviewQty,
    ProductDetailsProductModel? product,
    List<ProductDetailsProductModel>? relatedProducts,
    List<DetailsProductReviewModel>? productReviews,
    List<ProductVariantModel>? productVariants,
  }) {
    return ProductDetailsModel(
      id: id ?? this.id,
      totalProductReviewQty:
          totalProductReviewQty ?? this.totalProductReviewQty,
      product: product ?? this.product,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      productReviews: productReviews ?? this.productReviews,
      productVariants: productVariants ?? this.productVariants,
    );
  }

  factory ProductDetailsModel.fromMap(Map<String, dynamic> map) {
    return ProductDetailsModel(
      id: map['id']?.toInt() ?? -1,
      totalProductReviewQty: map['totalProductReviewQty']?.toInt() ?? -1,
      product: ProductDetailsProductModel.fromMap(map['product']),
      relatedProducts: map['relatedProducts'] != null
          ? List<ProductDetailsProductModel>.from(map['relatedProducts']
              ?.map((x) => ProductDetailsProductModel.fromMap(x)))
          : [],
      productVariants: map['productVariants'] != null
          ? List<ProductVariantModel>.from(map['productVariants']
              ?.map((x) => ProductVariantModel.fromMap(x)))
          : [],
      productReviews: filterReviews(map['productReviews']),
    );
  }
  static List<DetailsProductReviewModel> filterReviews(
      Map<String, dynamic>? map) {
    if (map == null) return [];
    final data = map['data'] as List?;
    if (data == null) return [];

    return data.map((e) => DetailsProductReviewModel.fromMap(e)).toList();
  }

  factory ProductDetailsModel.fromJson(String source) =>
      ProductDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductDetailsModel(id: $id, totalProductReviewQty: $totalProductReviewQty, product: $product, relatedProducts: $relatedProducts, productReviews: $productReviews)';
  }

  @override
  List<Object> get props {
    return [
      id,
      totalProductReviewQty,
      product,
      relatedProducts,
      productReviews,
    ];
  }
}
