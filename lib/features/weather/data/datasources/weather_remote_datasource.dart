import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> fetchWeather(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;
  final String apiKey;
  final String baseUrl;

  WeatherRemoteDataSourceImpl({
    required this.client,
    String? apiKey,
    String? baseUrl,
  })  : apiKey = apiKey ?? dotenv.env['WEATHER_API_KEY'] ?? '',
        baseUrl = baseUrl ?? 'https://api.openweathermap.org/data/2.5/weather';

  @override
  Future<WeatherModel> fetchWeather(double lat, double lon) async {
    final url = Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$apiKey');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }
}
