import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fact.g.dart';

@JsonSerializable()
class Fact {
  Fact({required this.fact}) {
    key = UniqueKey().toString();
    createdAt = DateTime.now();
  }

  @JsonKey(name: 'fact')
  final String fact;
  late String key;
  late DateTime createdAt;

  factory Fact.fromJson(Map<String, dynamic> json) => _$FactFromJson(json);

  Map<String, dynamic> toJson() => _$FactToJson(this);
}
