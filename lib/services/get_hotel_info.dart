import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_pw9/models/hotel_info.dart';

Future<HotelInfo> getHotelInfo(String uuid) async {
  String url = 'https://run.mocky.io/v3/$uuid';

  try {
    final response = await http.get(Uri.parse(url));
    assert(response.statusCode == 200);
    return HotelInfo.fromJson(jsonDecode(response.body));
  } catch (e) {
    return Future.error(e.toString());
  }
}
