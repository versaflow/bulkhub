import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../../utils/utils.dart';
import '../../home/model/setting_model.dart';
import '../../profile/model/address_model.dart';
import 'cart_product_model.dart';
import 'shipping_method_model.dart';

class CheckoutResponseModel extends Equatable {
  final List<CartProductModel> cartProducts;
  final List<ShippingMethodModel> shippingMethods;
  final String totalProduct;
  final num subTotalAmount;
  final num taxAmount;
  final num couponAmount;
  final num totalAmount;
  final SettingModel setting;

  final AddressModel? shipping;
  final AddressModel? billing;
  const CheckoutResponseModel({
    required this.cartProducts,
    required this.totalProduct,
    required this.subTotalAmount,
    required this.taxAmount,
    required this.couponAmount,
    required this.totalAmount,
    required this.setting,
    required this.shippingMethods,
    required this.shipping,
    required this.billing,
  });

  CheckoutResponseModel copyWith({
    List<CartProductModel>? cartProducts,
    List<ShippingMethodModel>? shippingMethods,
    String? totalProduct,
    num? subTotalAmount,
    num? taxAmount,
    num? couponAmount,
    num? totalAmount,
    SettingModel? setting,
    AddressModel? shipping,
    AddressModel? billing,
  }) {
    return CheckoutResponseModel(
      shippingMethods: shippingMethods ?? this.shippingMethods,
      cartProducts: cartProducts ?? this.cartProducts,
      totalProduct: totalProduct ?? this.totalProduct,
      subTotalAmount: subTotalAmount ?? this.subTotalAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      couponAmount: couponAmount ?? this.couponAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      setting: setting ?? this.setting,
      shipping: shipping ?? this.shipping,
      billing: billing ?? this.billing,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
        .addAll({'cartProducts': cartProducts.map((x) => x.toMap()).toList()});
    result.addAll(
        {'shippingMethods': shippingMethods.map((x) => x.toMap()).toList()});
    result.addAll({'totalProduct': totalProduct});
    result.addAll({'subTotalAmount': subTotalAmount});
    result.addAll({'taxAmount': taxAmount});
    result.addAll({'couponAmount': couponAmount});
    result.addAll({'totalAmount': totalAmount});
    result.addAll({'setting': setting.toMap()});
    if (shipping != null) {
      result.addAll({'shipping': shipping!.toMap()});
    }
    if (billing != null) {
      result.addAll({'billing': billing!.toMap()});
    }

    return result;
  }

  factory CheckoutResponseModel.fromMap(Map<String, dynamic> map) {
    return CheckoutResponseModel(
      cartProducts: map['cartProducts'] != null
          ? List<CartProductModel>.from(
              map['cartProducts']?.map((x) => CartProductModel.fromMap(x)))
          : [],
      shippingMethods: map['shippingMethods'] != null
          ? List<ShippingMethodModel>.from(map['shippingMethods']
              ?.map((x) => ShippingMethodModel.fromMap(x)))
          : [],
      totalProduct: map['totalProduct']?.toString() ?? '',
      subTotalAmount: map['subTotalAmount'] ?? 0,
      taxAmount: map['taxAmount'] ?? 0,
      couponAmount: Utils.toDouble((map['couponAmount'] ?? 0).toString()),
      totalAmount: map['totalAmount'] ?? 0,
      setting: SettingModel.fromMap(map['setting']),
      shipping: map['shipping'] != null
          ? AddressModel.fromMap(map['shipping'])
          : null,
      billing:
          map['billing'] != null ? AddressModel.fromMap(map['billing']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckoutResponseModel.fromJson(String source) =>
      CheckoutResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartResponseModel(cartProducts: $cartProducts, shippingMethods: $shippingMethods, totalProduct: $totalProduct, subTotalAmount: $subTotalAmount, taxAmount: $taxAmount, couponAmount: $couponAmount, totalAmount: $totalAmount, setting: $setting, shipping: $shipping)';
  }

  @override
  List<Object?> get props {
    return [
      cartProducts,
      totalProduct,
      subTotalAmount,
      taxAmount,
      couponAmount,
      totalAmount,
      setting,
      shippingMethods,
      shipping,
    ];
  }
}
