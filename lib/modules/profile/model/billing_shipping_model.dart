import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'address_model.dart';

class BillingShipingModel extends Equatable {
  final AddressModel? billing;
  final AddressModel? shipping;
  const BillingShipingModel({
    this.billing,
    this.shipping,
  });

  BillingShipingModel copyWith({
    AddressModel? billing,
    AddressModel? shipping,
  }) {
    return BillingShipingModel(
      billing: billing ?? this.billing,
      shipping: shipping ?? this.shipping,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (billing != null) {
      result.addAll({'billing': billing!.toMap()});
    }
    if (shipping != null) {
      result.addAll({'shipping': shipping!.toMap()});
    }

    return result;
  }

  factory BillingShipingModel.fromMap(Map<String, dynamic> map) {
    return BillingShipingModel(
      billing:
          map['billing'] != null ? AddressModel.fromMap(map['billing']) : null,
      shipping: map['shipping'] != null
          ? AddressModel.fromMap(map['shipping'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillingShipingModel.fromJson(String source) =>
      BillingShipingModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'BillingShipingModel(billing: $billing, shipping: $shipping)';

  @override
  List<Object?> get props => [billing, shipping];
}
