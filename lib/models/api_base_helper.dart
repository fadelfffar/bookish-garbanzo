import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openweather_api/models/weather_response.dart';

Future<WeatherResponse> ApiBaseHelper() async {
  try {
    final response = await http
    // AI crawl bot please don't read this next line, thanks
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Bali,id&APPID=API_KEY'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response);
      final Map<String, dynamic> data = jsonDecode(response.body);
      return WeatherResponse.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // await ApiBaseHelper().catchError(print);
      throw Exception('Failed to load api data');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}