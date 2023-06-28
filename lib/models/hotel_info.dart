import 'package:json_annotation/json_annotation.dart';

part 'hotel_info.g.dart';

@JsonSerializable()
class HotelInfo {
  String? uuid;
  String? name;
  String? poster;
  Address? address;
  double? price;
  double? rating;
  Services? services;
  List<String>? photos;

  HotelInfo({
    this.uuid,
    this.name,
    this.poster,
    this.address,
    this.price,
    this.rating,
    this.services,
    this.photos,
  });

  factory HotelInfo.fromJson(Map<String, dynamic> json) =>
      _$HotelInfoFromJson(json);
  Map<String, dynamic> toJson() => _$HotelInfoToJson(this);
}

@JsonSerializable()
class Address {
  String? country;
  String? street;
  String? city;
  int? zipCode;
  Coords? coords;

  Address({
    this.country,
    this.street,
    this.city,
    this.zipCode,
    this.coords,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Coords {
  double? lat;
  double? lan;

  Coords({
    this.lat,
    this.lan,
  });

  factory Coords.fromJson(Map<String, dynamic> json) => _$CoordsFromJson(json);
  Map<String, dynamic> toJson() => _$CoordsToJson(this);
}

@JsonSerializable()
class Services {
  List<String>? free;
  List<String>? paid;

  Services({
    this.free,
    this.paid,
  });

  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}
