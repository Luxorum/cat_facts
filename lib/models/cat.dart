import 'package:json_annotation/json_annotation.dart';

part 'cat.g.dart';

@JsonSerializable()
class Cat {
  Cat({required this.url});

  @JsonKey(name: 'url')
  final String url;

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

  Map<String, dynamic> toJson() => _$CatToJson(this);
}
