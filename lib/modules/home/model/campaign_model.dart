import 'dart:convert';

import 'package:equatable/equatable.dart';

class CampaignModel extends Equatable {
  final int id;
  final String name;
  final String title;
  final String image;
  final String slug;
  final int offer;
  final String startDate;
  final String endDate;
  final int showHomepage;
  final int status;
  final String createdAt;
  final String updatedAt;
  const CampaignModel({
    required this.id,
    required this.name,
    required this.title,
    required this.image,
    required this.slug,
    required this.offer,
    required this.startDate,
    required this.endDate,
    required this.showHomepage,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  CampaignModel copyWith({
    int? id,
    String? name,
    String? title,
    String? image,
    String? slug,
    int? offer,
    String? startDate,
    String? endDate,
    int? showHomepage,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return CampaignModel(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      image: image ?? this.image,
      slug: slug ?? this.slug,
      offer: offer ?? this.offer,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      showHomepage: showHomepage ?? this.showHomepage,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'title': title});
    result.addAll({'image': image});
    result.addAll({'slug': slug});
    result.addAll({'offer': offer});
    result.addAll({'start_date': startDate});
    result.addAll({'end_date': endDate});
    result.addAll({'show_homepage': showHomepage});
    result.addAll({'status': status});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});

    return result;
  }

  factory CampaignModel.fromMap(Map<String, dynamic> map) {
    return CampaignModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      slug: map['slug'] ?? '',
      offer: map['offer'] != null ? int.parse("${map['offer']}") : 0,
      startDate: map['start_date'] ?? '',
      endDate: map['end_date'] ?? '',
      showHomepage: map['show_homepage'] != null ? int.parse("${map['show_homepage']}") : 0,
      status: map['status'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CampaignModel.fromJson(String source) =>
      CampaignModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CampaignModel(id: $id, name: $name, title: $title, image: $image, slug: $slug, offer: $offer, startDate: $startDate, endDate: $endDate, showHomepage: $showHomepage, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      title,
      image,
      slug,
      offer,
      startDate,
      endDate,
      showHomepage,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
