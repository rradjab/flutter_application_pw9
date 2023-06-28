import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_pw9/models/hotel.dart';

Future<List<HotelModel>> getHotels() async {
  String url = 'https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301';

  try {
    final response = await http.get(Uri.parse(url));
    assert(response.statusCode == 200);
    return (jsonDecode(response.body) as List)
        .map((e) => HotelModel.fromJson(e))
        .toList();
  } catch (e) {
    return Future.error(e.toString());
  }
}
