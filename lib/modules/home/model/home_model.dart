import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../category/model/product_categories_model.dart';
import 'brand_model.dart';
import 'campaign_model.dart';
import 'campaign_products_model.dart';
import 'product_model.dart';
import 'setting_model.dart';
import 'slider_model.dart';

class HomeModel extends Equatable {
  final List<ProductCategoriesModel> productCategories;
  // final CampaignModel campaign;
  // final List<CampaignProductsModel> campaignProducts;
  final List<SliderModel> sliders;
  final List<SliderModel> banners;
  final List<ProductModel> flashDealProducts;
  final List<ProductModel> newProducts;
  final List<ProductModel> topProducts;
  final List<BrandModel> brands;
  final ProductCategoriesModel firstCategory;
  final ProductCategoriesModel secondCategory;
  final ProductCategoriesModel thirdCategory;
  final ProductCategoriesModel fourthCategory;
  final SettingModel setting;
  const HomeModel({
    required this.productCategories,
    // required this.campaign,
    // required this.campaignProducts,
    required this.sliders,
    required this.banners,
    required this.flashDealProducts,
    required this.newProducts,
    required this.topProducts,
    required this.brands,
    required this.firstCategory,
    required this.secondCategory,
    required this.thirdCategory,
    required this.fourthCategory,
    required this.setting,
  });

  HomeModel copyWith({
    List<ProductCategoriesModel>? productCategories,
    CampaignModel? campaign,
    List<CampaignProductsModel>? campaignProducts,
    List<SliderModel>? sliders,
    List<SliderModel>? banners,
    List<ProductModel>? flashDealProducts,
    List<ProductModel>? newProducts,
    List<ProductModel>? topProducts,
    List<BrandModel>? brands,
    ProductCategoriesModel? firstCategory,
    ProductCategoriesModel? secondCategory,
    ProductCategoriesModel? thirdCategory,
    ProductCategoriesModel? fourthCategory,
    SettingModel? setting,
  }) {
    return HomeModel(
      productCategories: productCategories ?? this.productCategories,
      // campaign: campaign ?? this.campaign,
      // campaignProducts: campaignProducts ?? this.campaignProducts,
      sliders: sliders ?? this.sliders,
      banners: banners ?? this.banners,
      flashDealProducts: flashDealProducts ?? this.flashDealProducts,
      newProducts: newProducts ?? this.newProducts,
      topProducts: topProducts ?? this.topProducts,
      brands: brands ?? this.brands,
      firstCategory: firstCategory ?? this.firstCategory,
      secondCategory: secondCategory ?? this.secondCategory,
      thirdCategory: thirdCategory ?? this.thirdCategory,
      fourthCategory: fourthCategory ?? this.fourthCategory,
      setting: setting ?? this.setting,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'productCategories': productCategories.map((x) => x.toMap()).toList()
    });
    // result.addAll({'campaign': campaign.toMap()});
    // result.addAll(
    //     {'campaignProducts': campaignProducts.map((x) => x.toMap()).toList()});
    result.addAll({'sliders': sliders.map((x) => x.toMap()).toList()});
    result.addAll({'banners': banners.map((x) => x.toMap()).toList()});
    result.addAll({
      'flashDealProducts': flashDealProducts.map((x) => x.toMap()).toList()
    });
    result.addAll({'newProducts': newProducts.map((x) => x.toMap()).toList()});
    result.addAll({'topProducts': topProducts.map((x) => x.toMap()).toList()});
    result.addAll({'brands': brands.map((x) => x.toMap()).toList()});
    result.addAll({'firstCategory': firstCategory.toMap()});
    result.addAll({'secondCategory': secondCategory.toMap()});
    result.addAll({'thirdCategory': thirdCategory.toMap()});
    result.addAll({'fourthCategory': fourthCategory.toMap()});
    result.addAll({'setting': setting.toMap()});

    return result;
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      productCategories: map['productCategories'] != null
          ? List<ProductCategoriesModel>.from(map['productCategories']
              .map((x) => ProductCategoriesModel.fromMap(x)))
          : [],
      // campaign: CampaignModel.fromMap(map['campaign']),
      // campaignProducts: map['campaignProducts'] != null
      //     ? List<CampaignProductsModel>.from(map['campaignProducts']
      //         .map((x) => CampaignProductsModel.fromMap(x)))
      //     : [],
      sliders: map['sliders'] != null
          ? List<SliderModel>.from(
              map['sliders'].map((x) => SliderModel.fromMap(x)))
          : [],
      banners: map['banners'] != null
          ? List<SliderModel>.from(
              map['banners'].map((x) => SliderModel.fromMap(x)))
          : [],
      flashDealProducts: map['flashDealProducts'] != null
          ? List<ProductModel>.from(
              map['flashDealProducts'].map((x) => ProductModel.fromMap(x)))
          : [],
      newProducts: map['newProducts'] != null
          ? List<ProductModel>.from(
              map['newProducts'].map((x) => ProductModel.fromMap(x)))
          : [],
      topProducts: map['topProducts'] != null
          ? List<ProductModel>.from(
              map['topProducts'].map((x) => ProductModel.fromMap(x)))
          : [],
      brands: map['brands'] != null
          ? List<BrandModel>.from(
              map['brands'].map((x) => BrandModel.fromMap(x)))
          : [],
      firstCategory: ProductCategoriesModel.fromMap(map['firstCategory']),
      secondCategory: ProductCategoriesModel.fromMap(map['secondCategory']),
      thirdCategory: ProductCategoriesModel.fromMap(map['thirdCategory']),
      fourthCategory: ProductCategoriesModel.fromMap(map['fourthCategory']),
      setting: SettingModel.fromMap(map['setting']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeModel(productCategories: $productCategories,  sliders: $sliders, banners: $banners, flashDealProducts: $flashDealProducts, newProducts: $newProducts, topProducts: $topProducts, brands: $brands, firstCategory: $firstCategory, secondCategory: $secondCategory, thirdCategory: $thirdCategory, fourthCategory: $fourthCategory, setting: $setting)';
  }

  @override
  List<Object> get props {
    return [
      productCategories,
      // campaign,
      // campaignProducts,
      sliders,
      banners,
      flashDealProducts,
      newProducts,
      topProducts,
      brands,
      firstCategory,
      secondCategory,
      thirdCategory,
      fourthCategory,
      setting,
    ];
  }
}
