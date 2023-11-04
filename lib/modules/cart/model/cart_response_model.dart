import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../../utils/utils.dart';
import '../../home/model/setting_model.dart';
import 'cart_product_model.dart';

class CartResponseModel extends Equatable {
  final List<CartProductModel> cartProducts;
  final String totalProduct;
  final num subTotalAmount;
  final num taxAmount;
  final num couponAmount;
  final num totalAmount;
  final SettingModel setting;
  const CartResponseModel({
    required this.cartProducts,
    required this.totalProduct,
    required this.subTotalAmount,
    required this.taxAmount,
    required this.couponAmount,
    required this.totalAmount,
    required this.setting,
  });

  CartResponseModel copyWith({
    List<CartProductModel>? cartProducts,
    String? totalProduct,
    num? subTotalAmount,
    num? taxAmount,
    num? couponAmount,
    num? totalAmount,
    SettingModel? setting,
  }) {
    return CartResponseModel(
      cartProducts: cartProducts ?? this.cartProducts,
      totalProduct: totalProduct ?? this.totalProduct,
      subTotalAmount: subTotalAmount ?? this.subTotalAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      couponAmount: couponAmount ?? this.couponAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      setting: setting ?? this.setting,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
        .addAll({'cartProducts': cartProducts.map((x) => x.toMap()).toList()});
    result.addAll({'totalProduct': totalProduct});
    result.addAll({'subTotalAmount': subTotalAmount});
    result.addAll({'taxAmount': taxAmount});
    result.addAll({'couponAmount': couponAmount});
    result.addAll({'totalAmount': totalAmount});
    result.addAll({'setting': setting.toMap()});

    return result;
  }

  factory CartResponseModel.fromMap(Map<String, dynamic> map) {
    return CartResponseModel(
      cartProducts: List<CartProductModel>.from(
          map['cartProducts']?.map((x) => CartProductModel.fromMap(x))),
      totalProduct: map['totalProduct']?.toString() ?? '',
      subTotalAmount: map['subTotalAmount'] ?? 0,
      taxAmount: map['taxAmount'] ?? 0,
      couponAmount: Utils.toDouble((map['couponAmount'] ?? 0).toString()),
      totalAmount: map['totalAmount'] ?? 0,
      setting: SettingModel.fromMap(map['setting']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartResponseModel.fromJson(String source) =>
      CartResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartResponseModel(cartProducts: $cartProducts, totalProduct: $totalProduct, subTotalAmount: $subTotalAmount, taxAmount: $taxAmount, couponAmount: $couponAmount, totalAmount: $totalAmount, setting: $setting)';
  }

  @override
  List<Object> get props {
    return [
      cartProducts,
      totalProduct,
      subTotalAmount,
      taxAmount,
      couponAmount,
      totalAmount,
      setting,
    ];
  }
}
