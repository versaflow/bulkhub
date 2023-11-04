import 'dart:convert';

import 'package:equatable/equatable.dart';
import '../../category/model/product_categories_model.dart';
import '../../home/model/brand_model.dart';
import '../../home/model/product_model.dart';
import 'tax_model.dart';
import 'variant_items_model.dart';

class ProductDetailsProductModel extends Equatable {
  final int id;
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
  final String seoTitle;
  final String seoDescription;
  final int price;
  final int offerPrice;
  final int taxId;
  final int isCashDelivery;
  final int isReturn;
  final int isWarranty;
  final int isFeatured;
  final int status;
  final TaxModel? tax;
  final List<GalleryModel> gallery;

  final List<VariantItemModel> variantItems;
  final ProductCategoriesModel category;
  final BrandModel brand;
  const ProductDetailsProductModel({
    required this.id,
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
    required this.seoTitle,
    required this.seoDescription,
    required this.price,
    required this.offerPrice,
    required this.taxId,
    required this.isCashDelivery,
    required this.isReturn,
    required this.isWarranty,
    required this.isFeatured,
    required this.status,
    this.tax,
    required this.gallery,
    required this.variantItems,
    required this.category,
    required this.brand,
  });

  ProductDetailsProductModel copyWith({
    int? id,
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
    String? seoTitle,
    String? seoDescription,
    int? price,
    int? offerPrice,
    int? taxId,
    int? isCashDelivery,
    int? isReturn,
    int? isWarranty,
    int? isFeatured,
    int? status,
    TaxModel? tax,
    List<GalleryModel>? gallery,
    List<VariantItemModel>? variantItems,
    ProductCategoriesModel? category,
    BrandModel? brand,
  }) {
    return ProductDetailsProductModel(
      id: id ?? this.id,
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
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      taxId: taxId ?? this.taxId,
      isCashDelivery: isCashDelivery ?? this.isCashDelivery,
      isReturn: isReturn ?? this.isReturn,
      isWarranty: isWarranty ?? this.isWarranty,
      isFeatured: isFeatured ?? this.isFeatured,
      status: status ?? this.status,
      tax: tax ?? this.tax,
      gallery: gallery ?? this.gallery,
      variantItems: variantItems ?? this.variantItems,
      category: category ?? this.category,
      brand: brand ?? this.brand,
    );
  }

  factory ProductDetailsProductModel.fromMap(Map<String, dynamic> map) {
    return ProductDetailsProductModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      shortName: map['short_name'] ?? '',
      slug: map['slug'] ?? '',
      thumbImage: map['thumb_image'] ?? '',
      bannerImage: map['banner_image'] ?? '',
      vendorId: map['vendor_id'] ?? 0,
      categoryId: map['category_id'] ?? 0,
      brandId: map['brand_id'] ?? 0,
      qty: map['qty'] ?? 0,
      shortDescription: map['short_description'] ?? '',
      longDescription: map['long_description'] ?? '',
      videoLink: map['video_link'] ?? '',
      sku: map['sku'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      price: map['price'] ?? -1,
      offerPrice: map['offer_price'] ?? -1,
      taxId: map['tax_id'] ?? 0,
      isCashDelivery: map['is_cash_delivery'] ?? 0,
      isReturn: map['is_return'] ?? 0,
      isWarranty: map['is_warranty'] ?? 0,
      isFeatured: map['is_featured'] ?? 0,
      status: map['status'] ?? 0,
      tax: map['tax'] != null ? TaxModel.fromMap(map['tax']) : null,
      gallery: map['gallery'] != null
          ? List<GalleryModel>.from(
              map['gallery']?.map((x) => GalleryModel.fromMap(x)))
          : [],
      variantItems: map['variant_items'] != null
          ? List<VariantItemModel>.from(
              map['variant_items']?.map((x) => VariantItemModel.fromMap(x)))
          : [],
      category: ProductCategoriesModel.fromMap(map['category']),
      brand: BrandModel.fromMap(map['brand']),
    );
  }

  factory ProductDetailsProductModel.fromJson(String source) =>
      ProductDetailsProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DetailsProductModel(id: $id, name: $name, shortName: $shortName, slug: $slug, thumbImage: $thumbImage, bannerImage: $bannerImage, vendorId: $vendorId, categoryId: $categoryId, brandId: $brandId, qty: $qty, shortDescription: $shortDescription, longDescription: $longDescription, videoLink: $videoLink, sku: $sku, seoTitle: $seoTitle, seoDescription: $seoDescription, price: $price, offerPrice: $offerPrice, taxId: $taxId, isCashDelivery: $isCashDelivery, isReturn: $isReturn, isWarranty: $isWarranty, isFeatured: $isFeatured, status: $status, tax: $tax, gallery: $gallery, variant_items: $variantItems, category: $category, brand: $brand)';
  }

  @override
  List<Object> get props {
    return [
      id,
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
      seoTitle,
      seoDescription,
      price,
      offerPrice,
      taxId,
      isCashDelivery,
      isReturn,
      isWarranty,
      isFeatured,
      status,
      gallery,
      variantItems,
      category,
      brand,
    ];
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
    result.addAll({'seo_title': seoTitle});
    result.addAll({'seo_description': seoDescription});
    result.addAll({'price': price});
    result.addAll({'offer_price': offerPrice});
    result.addAll({'tax_id': taxId});
    result.addAll({'is_cash_delivery': isCashDelivery});
    result.addAll({'is_return': isReturn});
    result.addAll({'is_warranty': isWarranty});
    result.addAll({'is_featured': isFeatured});
    result.addAll({'status': status});
    if (tax != null) {
      result.addAll({'tax': tax!.toMap()});
    }
    result.addAll({'gallery': gallery.map((x) => x.toMap()).toList()});
    result
        .addAll({'variant_items': variantItems.map((x) => x.toMap()).toList()});
    result.addAll({'category': category.toMap()});
    result.addAll({'brand': brand.toMap()});

    return result;
  }

  String toJson() => json.encode(toMap());
}
