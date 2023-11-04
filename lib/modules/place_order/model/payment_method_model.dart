import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentMethodModel extends Equatable {
  final int id;
  final String status;
  final String stripeKey;
  final String stripeSecret;
  final String countryCode;
  final String currencyCode;
  final String currencyRate;
  final String accountMode;
  const PaymentMethodModel({
    required this.id,
    required this.status,
    required this.stripeKey,
    required this.stripeSecret,
    required this.countryCode,
    required this.currencyCode,
    required this.currencyRate,
    required this.accountMode,
  });

  PaymentMethodModel copyWith({
    int? id,
    String? status,
    String? stripeKey,
    String? stripeSecret,
    String? countryCode,
    String? currencyCode,
    String? currencyRate,
    String? accountMode,
  }) {
    return PaymentMethodModel(
      id: id ?? this.id,
      status: status ?? this.status,
      stripeKey: stripeKey ?? this.stripeKey,
      stripeSecret: stripeSecret ?? this.stripeSecret,
      countryCode: countryCode ?? this.countryCode,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyRate: currencyRate ?? this.currencyRate,
      accountMode: accountMode ?? this.accountMode,
    );
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      id: map['id']?.toInt() ?? 0,
      status: map['status'] ?? '',
      stripeKey: map['stripe_key'] ?? '',
      stripeSecret: map['stripe_secret'] ?? '',
      countryCode: map['country_code'] ?? '',
      currencyCode: map['currency_code'] ?? '',
      currencyRate: map['currency_rate'] ?? '',
      accountMode: map['account_mode'] ?? '',
    );
  }

  factory PaymentMethodModel.fromJson(String source) =>
      PaymentMethodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentMethodModel(id: $id, status: $status, stripeKey: $stripeKey, stripeSecret: $stripeSecret, countryCode: $countryCode, currencyCode: $currencyCode, currencyRate: $currencyRate, accountMode: $accountMode)';
  }

  @override
  List<Object> get props {
    return [
      id,
      status,
      stripeKey,
      stripeSecret,
      countryCode,
      currencyCode,
      currencyRate,
      accountMode,
    ];
  }
}
