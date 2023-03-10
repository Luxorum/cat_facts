import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fact.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Fact {
  Fact({required this.fact}) {
    key = UniqueKey().toString();
    createdAt = DateTime.now();
  }

  @JsonKey(name: 'fact')
  @HiveField(0)
  final String fact;

  @JsonKey(includeFromJson: false, includeToJson: true)
  @HiveField(1)
  late String key;

  @JsonKey(includeFromJson: false, includeToJson: true)
  @HiveField(2)
  late DateTime createdAt;

  factory Fact.fromJson(Map<String, dynamic> json) => _$FactFromJson(json);

  Map<String, dynamic> toJson() => _$FactToJson(this);
}
