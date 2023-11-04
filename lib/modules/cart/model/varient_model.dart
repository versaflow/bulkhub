import 'dart:convert';
import 'package:equatable/equatable.dart';

class VarientModel extends Equatable {
  final int id;
  final int shoppingCartId;
  final String name;
  final String value;
  final int price;
  final String createdAt;
  final String updatedAt;
  const VarientModel({
    required this.id,
    required this.shoppingCartId,
    required this.name,
    required this.value,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  VarientModel copyWith({
    int? id,
    int? shoppingCartId,
    String? name,
    String? value,
    int? price,
    String? createdAt,
    String? updatedAt,
  }) {
    return VarientModel(
      id: id ?? this.id,
      shoppingCartId: shoppingCartId ?? this.shoppingCartId,
      name: name ?? this.name,
      value: value ?? this.value,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'shopping_cart_id': shoppingCartId});
    result.addAll({'name': name});
    result.addAll({'value': value});
    result.addAll({'price': price});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});

    return result;
  }

  factory VarientModel.fromMap(Map<String, dynamic> map) {
    return VarientModel(
      id: map['id']?.toInt() ?? 0,
      shoppingCartId: map['shopping_cart_id'] ?? 0,
      name: map['name'] ?? '',
      value: map['value'] ?? '',
      price: map['price'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VarientModel.fromJson(String source) =>
      VarientModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VarientModel(id: $id, shopping_cart_id: $shoppingCartId, name: $name, value: $value, price: $price, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      shoppingCartId,
      name,
      value,
      price,
      createdAt,
      updatedAt,
    ];
  }
}
