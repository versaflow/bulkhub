import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaxModel extends Equatable {
  final int id;
  final int price;
  final String title;
  final int status;
  final String createdAt;
  final String updatedAt;
  const TaxModel({
    required this.id,
    required this.price,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  TaxModel copyWith({
    int? id,
    int? price,
    String? title,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return TaxModel(
      id: id ?? this.id,
      price: price ?? this.price,
      title: title ?? this.title,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'price': price});
    result.addAll({'title': title});
    result.addAll({'status': status});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});

    return result;
  }

  factory TaxModel.fromMap(Map<String, dynamic> map) {
    return TaxModel(
      id: map['id']?.toInt() ?? 0,
      price: map['price'] != null ? int.parse("${map['price']}") : 0,
      title: map['title'] ?? '',
      status: map['status'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TaxModel.fromJson(String source) =>
      TaxModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaxModel(id: $id, price: $price, title: $title, status: $status, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object> get props => [id, price, title, status, createdAt, updatedAt];
}
