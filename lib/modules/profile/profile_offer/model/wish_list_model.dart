import 'dart:convert';
import 'package:equatable/equatable.dart';

class WishListModel extends Equatable {
  final int id;
  final int wishId;
  final String name;
  final String shortName;
  final String slug;
  final String thumbImage;
  final String bannerImage;
  final int vendorId;
  final int categoryId;
  final int brandId;
  final int qty;
  final String shortDescription;
  final String longDescription;
  final String videoLink;
  final String sku;
  final int price;
  final int offerPrice;
  final int taxId;
  final int isCashDelivery;
  final int isReturn;
  final int isWarranty;
  final int isFeatured;
  final int status;
  const WishListModel({
    required this.id,
    required this.wishId,
    required this.name,
    required this.shortName,
    required this.slug,
    required this.thumbImage,
    required this.bannerImage,
    required this.vendorId,
    required this.categoryId,
    required this.brandId,
    required this.qty,
    required this.shortDescription,
    required this.longDescription,
    required this.videoLink,
    required this.sku,
    required this.price,
    required this.offerPrice,
    required this.taxId,
    required this.isCashDelivery,
    required this.isReturn,
    required this.isWarranty,
    required this.isFeatured,
    required this.status,
  });

  WishListModel copyWith({
    int? id,
    int? wishId,
    String? name,
    String? shortName,
    String? slug,
    String? thumbImage,
    String? bannerImage,
    int? vendorId,
    int? categoryId,
    int? brandId,
    int? qty,
    String? shortDescription,
    String? longDescription,
    String? videoLink,
    String? sku,
    int? price,
    int? offerPrice,
    int? taxId,
    int? isCashDelivery,
    int? isReturn,
    int? isWarranty,
    int? isFeatured,
    int? status,
  }) {
    return WishListModel(
      id: id ?? this.id,
      wishId: wishId ?? this.wishId,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      slug: slug ?? this.slug,
      thumbImage: thumbImage ?? this.thumbImage,
      bannerImage: bannerImage ?? this.bannerImage,
      vendorId: vendorId ?? this.vendorId,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      qty: qty ?? this.qty,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      videoLink: videoLink ?? this.videoLink,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      taxId: taxId ?? this.taxId,
      isCashDelivery: isCashDelivery ?? this.isCashDelivery,
      isReturn: isReturn ?? this.isReturn,
      isWarranty: isWarranty ?? this.isWarranty,
      isFeatured: isFeatured ?? this.isFeatured,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'short_name': shortName});
    result.addAll({'slug': slug});
    result.addAll({'thumb_image': thumbImage});
    result.addAll({'banner_image': bannerImage});
    result.addAll({'vendor_id': vendorId});
    result.addAll({'category_id': categoryId});
    result.addAll({'brand_id': brandId});
    result.addAll({'qty': qty});
    result.addAll({'short_description': shortDescription});
    result.addAll({'long_description': longDescription});
    result.addAll({'video_link': videoLink});
    result.addAll({'sku': sku});
    result.addAll({'price': price});
    result.addAll({'offer_price': offerPrice});
    result.addAll({'tax_id': taxId});
    result.addAll({'is_cash_delivery': isCashDelivery});
    result.addAll({'is_return': isReturn});
    result.addAll({'is_warranty': isWarranty});
    result.addAll({'is_featured': isFeatured});
    result.addAll({'status': status});
    result.addAll({'wish_id': wishId});

    return result;
  }

  factory WishListModel.fromMap(Map<String, dynamic> map) {
    return WishListModel(
      id: map['id']?.toInt() ?? 0,
      wishId: map['wish_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      shortName: map['short_name'] ?? '',
      slug: map['slug'] ?? '',
      thumbImage: map['thumb_image'] ?? '',
      bannerImage: map['banner_image'] ?? '',
      vendorId: map['vendor_id']  ?? 0,
      categoryId: map['category_id'] ?? 0,
      brandId: map['brand_id'] ?? 0,
      qty: map['qty'] ?? 0,
      shortDescription: map['short_description'] ?? '',
      longDescription: map['long_description'] ?? '',
      videoLink: map['video_link'] ?? '',
      sku: map['sku'] ?? '',
      price: map['price'] ?? 0,
      offerPrice: map['offer_price'] ?? 0,
      taxId: map['tax_id'] ?? 0,
      isCashDelivery: map['is_cash_delivery'] ?? 0,
      isReturn: map['is_return'] ?? 0,
      isWarranty: map['is_warranty'] ?? 0,
      isFeatured: map['is_featured'] ?? 0,
      status: map['status'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishListModel.fromJson(String source) =>
      WishListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, short_name: $shortName, slug: $slug, thumb_image: $thumbImage, banner_image: $bannerImage, vendor_id: $vendorId, category_id: $categoryId, brand_id: $brandId, qty: $qty, short_description: $shortDescription, long_description: $longDescription, video_link: $videoLink, sku: $sku, price: $price, offer_price: $offerPrice, tax_id: $taxId, is_cash_delivery: $isCashDelivery, is_return: $isReturn, is_warranty: $isWarranty, is_featured: $isFeatured, status: $status, wishId: $wishId)';
  }

  @override
  List<Object> get props {
    return [
      id,
      wishId,
      name,
      shortName,
      slug,
      thumbImage,
      bannerImage,
      vendorId,
      categoryId,
      brandId,
      qty,
      shortDescription,
      longDescription,
      videoLink,
      sku,
      price,
      offerPrice,
      taxId,
      isCashDelivery,
      isReturn,
      isWarranty,
      isFeatured,
      status,
    ];
  }
}
