import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../home/model/product_model.dart';

class ProductCategoriesModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String icon;
  final int status;
  final int isFeatured;
  final int isTop;
  final int isPopular;
  final int isTrending;
  final String createdAt;
  final String updatedAt;
  final List<ProductModel> products;

  const ProductCategoriesModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.status,
    required this.isFeatured,
    required this.isTop,
    required this.isPopular,
    required this.isTrending,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
  });

  ProductCategoriesModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? icon,
    int? status,
    int? isFeatured,
    int? isTop,
    int? isPopular,
    int? isTrending,
    String? createdAt,
    String? updatedAt,
    List<ProductModel>? products,
  }) {
    return ProductCategoriesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      icon: icon ?? this.icon,
      status: status ?? this.status,
      isFeatured: isFeatured ?? this.isFeatured,
      isTop: isTop ?? this.isTop,
      isPopular: isPopular ?? this.isPopular,
      isTrending: isTrending ?? this.isTrending,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'slug': slug});
    result.addAll({'icon': icon});
    result.addAll({'status': status});
    result.addAll({'isFeatured': isFeatured});
    result.addAll({'isTop': isTop});
    result.addAll({'isPopular': isPopular});
    result.addAll({'isTrending': isTrending});
    result.addAll({'createdAt': createdAt});
    result.addAll({'updatedAt': updatedAt});
    result.addAll({'products': products.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ProductCategoriesModel.fromMap(Map<String, dynamic> map) {
    return ProductCategoriesModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      icon: map['icon'] ?? '',
      status:  map['status'] ?? 0,
      isFeatured: map['isFeatured'] ?? 0,
      isTop: map['isTop'] ?? 0,
      isPopular: map['isPopular'] ?? 0,
      isTrending: map['isTrending'] ?? 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      products: map['products'] != null
          ? List<ProductModel>.from(
              map['products']?.map((x) => ProductModel.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategoriesModel.fromJson(String source) =>
      ProductCategoriesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductCategoriesModel(id: $id, name: $name, slug: $slug, icon: $icon, status: $status, isFeatured: $isFeatured, isTop: $isTop, isPopular: $isPopular, isTrending: $isTrending, createdAt: $createdAt, updatedAt: $updatedAt, products: $products)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      icon,
      status,
      isFeatured,
      isTop,
      isPopular,
      isTrending,
      createdAt,
      updatedAt,
      products,
    ];
  }
}
