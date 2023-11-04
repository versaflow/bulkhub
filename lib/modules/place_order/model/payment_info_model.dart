import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../../utils/utils.dart';
import '../../cart/model/cart_product_model.dart';
import '../../home/model/setting_model.dart';

class PaymentInfoModel extends Equatable {
  final List<CartProductModel> cartProducts;
  final List<String> paymentInfo;
  final String totalProduct;
  final num subTotalAmount;
  final num taxAmount;
  final num couponAmount;
  final num totalAmount;
  final SettingModel setting;

  const PaymentInfoModel({
    required this.cartProducts,
    required this.totalProduct,
    required this.subTotalAmount,
    required this.taxAmount,
    required this.couponAmount,
    required this.totalAmount,
    required this.setting,
    required this.paymentInfo,
  });

  PaymentInfoModel copyWith({
    List<CartProductModel>? cartProducts,
    List<String>? paymentInfo,
    String? totalProduct,
    num? subTotalAmount,
    num? taxAmount,
    num? couponAmount,
    num? totalAmount,
    SettingModel? setting,
  }) {
    return PaymentInfoModel(
      paymentInfo: paymentInfo ?? this.paymentInfo,
      cartProducts: cartProducts ?? this.cartProducts,
      totalProduct: totalProduct ?? this.totalProduct,
      subTotalAmount: subTotalAmount ?? this.subTotalAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      couponAmount: couponAmount ?? this.couponAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      setting: setting ?? this.setting,
    );
  }

  factory PaymentInfoModel.fromMap(Map<String, dynamic> map) {
    return PaymentInfoModel(
      cartProducts: map['cartProducts'] != null
          ? List<CartProductModel>.from(
              map['cartProducts']?.map((x) => CartProductModel.fromMap(x)))
          : [],
      paymentInfo: map['payment_info'] != null
          ? List<String>.from(map['payment_info']?.keys)
          : [],
      totalProduct: map['totalProduct']?.toString() ?? '',
      subTotalAmount: map['subTotalAmount'] ?? 0,
      taxAmount: map['taxAmount'] ?? 0,
      couponAmount: Utils.toDouble((map['couponAmount'] ?? 0).toString()),
      totalAmount: map['totalAmount'] ?? 0,
      setting: SettingModel.fromMap(map['setting']),
    );
  }

  factory PaymentInfoModel.fromJson(String source) =>
      PaymentInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartResponseModel(cartProducts: $cartProducts, totalProduct: $totalProduct, subTotalAmount: $subTotalAmount, taxAmount: $taxAmount, couponAmount: $couponAmount, totalAmount: $totalAmount, setting: $setting )';
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
    ];
  }
}
