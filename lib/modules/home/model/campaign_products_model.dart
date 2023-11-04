import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'campaign_model.dart';
import 'product_model.dart';

class CampaignProductsModel extends Equatable {
  final int id;
  final int campaignId;
  final int productId;
  final int showHomepage;
  final int status;
  final String createdAt;
  final String updatedAt;
  final CampaignModel campaign;
  final ProductModel product;

  const CampaignProductsModel({
    required this.id,
    required this.campaignId,
    required this.productId,
    required this.showHomepage,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.campaign,
    required this.product,
  });

  CampaignProductsModel copyWith({
    int? id,
    int? campaignId,
    int? productId,
    int? showHomepage,
    int? status,
    String? createdAt,
    String? updatedAt,
    CampaignModel? campaign,
    ProductModel? product,
  }) {
    return CampaignProductsModel(
      id: id ?? this.id,
      campaignId: campaignId ?? this.campaignId,
      productId: productId ?? this.productId,
      showHomepage: showHomepage ?? this.showHomepage,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      campaign: campaign ?? this.campaign,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'campaign_id': campaignId});
    result.addAll({'product_id': productId});
    result.addAll({'show_homepage': showHomepage});
    result.addAll({'status': status});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    result.addAll({'campaign': campaign.toMap()});
    result.addAll({'product': product.toMap()});

    return result;
  }

  factory CampaignProductsModel.fromMap(Map<String, dynamic> map) {
    return CampaignProductsModel(
      id: map['id']?.toInt() ?? 0,
      campaignId:
          map['campaign_id'] != null ? int.parse("${map['campaign_id']}") : 0,
      productId:
          map['product_id'] != null ? int.parse("${map['product_id']}") : 0,
      showHomepage: map['show_homepage'] != null
          ? int.parse("${map['show_homepage']}")
          : 0,
      status: map['status'] != null ? int.parse("${map['status']}") : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      campaign: CampaignModel.fromMap(map['campaign']),
      product: ProductModel.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CampaignProductsModel.fromJson(String source) =>
      CampaignProductsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'campaignProductsModel(id: $id, campaignId: $campaignId, productId: $productId, showHomepage: $showHomepage, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, campaign: $campaign, product: $product)';
  }

  @override
  List<Object> get props {
    return [
      id,
      campaignId,
      productId,
      showHomepage,
      status,
      createdAt,
      updatedAt,
      campaign,
      product,
    ];
  }
}
