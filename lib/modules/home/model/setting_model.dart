import 'dart:convert';

import 'package:equatable/equatable.dart';

class SettingModel extends Equatable {
  final String logo;
  final String favicon;
  final String contactEmail;
  final String timezone;
  final String topbarPhone;
  final String currencyName;
  final String currencyIcon;
  const SettingModel({
    required this.logo,
    required this.favicon,
    required this.contactEmail,
    required this.timezone,
    required this.topbarPhone,
    required this.currencyName,
    required this.currencyIcon,
  });

  SettingModel copyWith({
    String? logo,
    String? favicon,
    String? contactEmail,
    String? timezone,
    String? topbarPhone,
    String? currencyName,
    String? currencyIcon,
  }) {
    return SettingModel(
      logo: logo ?? this.logo,
      favicon: favicon ?? this.favicon,
      contactEmail: contactEmail ?? this.contactEmail,
      timezone: timezone ?? this.timezone,
      topbarPhone: topbarPhone ?? this.topbarPhone,
      currencyName: currencyName ?? this.currencyName,
      currencyIcon: currencyIcon ?? this.currencyIcon,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'logo': logo});
    result.addAll({'favicon': favicon});
    result.addAll({'contact_email': contactEmail});
    result.addAll({'timezone': timezone});
    result.addAll({'topbar_phone': topbarPhone});
    result.addAll({'currency_name': currencyName});
    result.addAll({'currency_icon': currencyIcon});

    return result;
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      logo: map['logo'] ?? '',
      favicon: map['favicon'] ?? '',
      contactEmail: map['contact_email'] ?? '',
      timezone: map['timezone'] ?? '',
      topbarPhone: map['topbar_phone'] ?? '',
      currencyName: map['currency_name'] ?? '',
      currencyIcon: map['currency_icon'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingModel.fromJson(String source) =>
      SettingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SettingModel(logo: $logo, favicon: $favicon, contact_email: $contactEmail, timezone: $timezone, topbar_phone: $topbarPhone, currency_name: $currencyName, currency_icon: $currencyIcon)';
  }

  @override
  List<Object> get props {
    return [
      logo,
      favicon,
      contactEmail,
      timezone,
      topbarPhone,
      currencyName,
      currencyIcon,
    ];
  }
}
