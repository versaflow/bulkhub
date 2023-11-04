import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'product_order_model.dart';

class OrderModel extends Equatable {
  final int id;
  final String orderId;
  final int userId;
  final double amountUsd;
  final int subTotal;
  final double amountRealCurrency;
  final double currencyRate;
  final String currencyName;
  final String currencyIcon;
  final int productQty;
  final String paymentMethod;
  final int paymentStatus;
  final String? paymentApprovalDate;
  final int refoundStatus;
  final String? paymentRefoundDate;
  final String? transectionId;
  final String shippingMethod;
  final int shippingCost;
  final int couponCoast;
  final double orderVat;
  final int orderStatus;
  final String? orderApprovalDate;
  final String? orderDeliveredDate;
  final String? orderCompletedDate;
  final String? orderDeclinedDate;
  final int cashOnDelivery;
  final String additionalInfo;
  final String agreeTermsCondition;
  final String createdAt;
  final String updatedAt;
  final List<OrderedProductModel> orderProducts;

  const OrderModel({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.amountUsd,
    required this.subTotal,
    required this.amountRealCurrency,
    required this.currencyRate,
    required this.currencyName,
    required this.currencyIcon,
    required this.productQty,
    required this.paymentMethod,
    required this.paymentStatus,
    this.paymentApprovalDate,
    required this.refoundStatus,
    this.paymentRefoundDate,
    this.transectionId,
    required this.shippingMethod,
    required this.shippingCost,
    required this.couponCoast,
    required this.orderVat,
    required this.orderStatus,
    this.orderApprovalDate,
    this.orderDeliveredDate,
    this.orderCompletedDate,
    this.orderDeclinedDate,
    required this.cashOnDelivery,
    required this.additionalInfo,
    required this.agreeTermsCondition,
    required this.createdAt,
    required this.updatedAt,
    required this.orderProducts,
  });

  OrderModel copyWith({
    int? id,
    String? orderId,
    int? userId,
    double? amountUsd,
    int? subTotal,
    double? amountRealCurrency,
    double? currencyRate,
    String? currencyName,
    String? currencyIcon,
    int? productQty,
    String? paymentMethod,
    int? paymentStatus,
    String? paymentApprovalDate,
    int? refoundStatus,
    String? paymentRefoundDate,
    String? transectionId,
    String? shippingMethod,
    int? shippingCost,
    int? couponCoast,
    double? orderVat,
    int? orderStatus,
    String? orderApprovalDate,
    String? orderDeliveredDate,
    String? orderCompletedDate,
    String? orderDeclinedDate,
    int? cashOnDelivery,
    String? additionalInfo,
    String? agreeTermsCondition,
    String? createdAt,
    String? updatedAt,
    List<OrderedProductModel>? orderProducts,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      amountUsd: amountUsd ?? this.amountUsd,
      subTotal: subTotal ?? this.subTotal,
      amountRealCurrency: amountRealCurrency ?? this.amountRealCurrency,
      currencyRate: currencyRate ?? this.currencyRate,
      currencyName: currencyName ?? this.currencyName,
      currencyIcon: currencyIcon ?? this.currencyIcon,
      productQty: productQty ?? this.productQty,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentApprovalDate: paymentApprovalDate ?? this.paymentApprovalDate,
      refoundStatus: refoundStatus ?? this.refoundStatus,
      paymentRefoundDate: paymentRefoundDate ?? this.paymentRefoundDate,
      transectionId: transectionId ?? this.transectionId,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      shippingCost: shippingCost ?? this.shippingCost,
      couponCoast: couponCoast ?? this.couponCoast,
      orderVat: orderVat ?? this.orderVat,
      orderStatus: orderStatus ?? this.orderStatus,
      orderApprovalDate: orderApprovalDate ?? this.orderApprovalDate,
      orderDeliveredDate: orderDeliveredDate ?? this.orderDeliveredDate,
      orderCompletedDate: orderCompletedDate ?? this.orderCompletedDate,
      orderDeclinedDate: orderDeclinedDate ?? this.orderDeclinedDate,
      cashOnDelivery: cashOnDelivery ?? this.cashOnDelivery,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      agreeTermsCondition: agreeTermsCondition ?? this.agreeTermsCondition,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      orderProducts: orderProducts ?? this.orderProducts,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'order_id': orderId});
    result.addAll({'user_id': userId});
    result.addAll({'amount_usd': amountUsd});
    result.addAll({'sub_total': subTotal});
    result.addAll({'amount_real_currency': amountRealCurrency});
    result.addAll({'currency_rate': currencyRate});
    result.addAll({'currency_name': currencyName});
    result.addAll({'currency_icon': currencyIcon});
    result.addAll({'product_qty': productQty});
    result.addAll({'payment_method': paymentMethod});
    result.addAll({'payment_status': paymentStatus});
    if (paymentApprovalDate != null) {
      result.addAll({'payment_approval_date': paymentApprovalDate});
    }
    result.addAll({'refound_status': refoundStatus});
    if (paymentRefoundDate != null) {
      result.addAll({'payment_refound_date': paymentRefoundDate});
    }
    if (transectionId != null) {
      result.addAll({'transection_id': transectionId});
    }
    result.addAll({'shipping_method': shippingMethod});
    result.addAll({'shipping_cost': shippingCost});
    result.addAll({'coupon_coast': couponCoast});
    result.addAll({'order_vat': orderVat});
    result.addAll({'order_status': orderStatus});
    if (orderApprovalDate != null) {
      result.addAll({'order_approval_date': orderApprovalDate});
    }
    if (orderDeliveredDate != null) {
      result.addAll({'order_delivered_date': orderDeliveredDate});
    }
    if (orderCompletedDate != null) {
      result.addAll({'order_completed_date': orderCompletedDate});
    }
    if (orderDeclinedDate != null) {
      result.addAll({'order_declined_date': orderDeclinedDate});
    }
    result.addAll({'cash_on_delivery': cashOnDelivery});
    result.addAll({'additional_info': additionalInfo});
    result.addAll({'agree_terms_condition': agreeTermsCondition});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    result.addAll(
        {'order_products': orderProducts.map((x) => x.toMap()).toList()});

    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt() ?? 0,
      orderId: map['order_id'] ?? '',
      userId: map['user_id'] != null ? int.parse("${map['user_id']}") : 0,
      amountUsd: map['amount_usd'] != null
          ? double.parse("${map['amount_usd']}")
          : 0.0,
      subTotal: map['sub_total'] ?? '',
      amountRealCurrency: map['amount_real_currency'] != null
          ? double.parse("${map['amount_real_currency']}")
          : 0.0,
      currencyRate: map['currency_rate'] != null
          ? double.parse("${map['currency_rate']}")
          : 0.0,
      currencyName: map['currency_name'] ?? '',
      currencyIcon: map['currency_icon'] ?? '',
      productQty: map['product_qty'] ?? '',
      paymentMethod: map['payment_method'] ?? '',
      paymentStatus: map['payment_status'] ?? '',
      paymentApprovalDate: map['payment_approval_date'],
      refoundStatus: map['refound_status'] ?? '',
      paymentRefoundDate: map['payment_refound_date'],
      transectionId: map['transection_id'],
      shippingMethod: map['shipping_method'] ?? '',
      shippingCost: map['shipping_cost'] ?? '',
      couponCoast: map['coupon_coast'] ?? '',
      orderVat:
          map['order_vat'] != null ? double.parse("${map['order_vat']}") : 0.0,
      orderStatus: map['order_status'] ?? '',
      orderApprovalDate: map['order_approval_date'],
      orderDeliveredDate: map['order_delivered_date'],
      orderCompletedDate: map['order_completed_date'],
      orderDeclinedDate: map['order_declined_date'],
      cashOnDelivery: map['cash_on_delivery'] ?? '',
      additionalInfo: map['additional_info'] ?? '',
      agreeTermsCondition: map['agree_termsCondition'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      orderProducts: List<OrderedProductModel>.from(
          map['order_products']?.map((x) => OrderedProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, orderId: $orderId, userId: $userId, amountUsd: $amountUsd, subTotal: $subTotal, amountRealCurrency: $amountRealCurrency, currencyRate: $currencyRate, currencyName: $currencyName, currencyIcon: $currencyIcon, productQty: $productQty, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, paymentApprovalDate: $paymentApprovalDate, refoundStatus: $refoundStatus, paymentRefoundDate: $paymentRefoundDate, transectionId: $transectionId, shippingMethod: $shippingMethod, shippingCost: $shippingCost, couponCoast: $couponCoast, orderVat: $orderVat, orderStatus: $orderStatus, orderApprovalDate: $orderApprovalDate, orderDeliveredDate: $orderDeliveredDate, orderCompletedDate: $orderCompletedDate, orderDeclinedDate: $orderDeclinedDate, cashOnDelivery: $cashOnDelivery, additionalInfo: $additionalInfo, agreeTermsCondition: $agreeTermsCondition, createdAt: $createdAt, updatedAt: $updatedAt, orderProducts: $orderProducts)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      orderId,
      userId,
      amountUsd,
      subTotal,
      amountRealCurrency,
      currencyRate,
      currencyName,
      currencyIcon,
      productQty,
      paymentMethod,
      paymentStatus,
      paymentApprovalDate,
      refoundStatus,
      paymentRefoundDate,
      transectionId,
      shippingMethod,
      shippingCost,
      couponCoast,
      orderVat,
      orderStatus,
      orderApprovalDate,
      orderDeliveredDate,
      orderCompletedDate,
      orderDeclinedDate,
      cashOnDelivery,
      additionalInfo,
      agreeTermsCondition,
      createdAt,
      updatedAt,
      orderProducts,
    ];
  }
}
