import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable()
class HotelModel {
  String uuid;
  String name;
  String poster;
  HotelModel({required this.uuid, required this.name, required this.poster});

  factory HotelModel.fromJson(Map<String, dynamic> json) =>
      _$HotelModelFromJson(json);
  Map<String, dynamic> toJson() => _$HotelModelToJson(this);
}
