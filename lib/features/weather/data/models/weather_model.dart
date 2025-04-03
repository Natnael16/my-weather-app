// lib/data/models/weather_model.dart
import '../../domain/entities/weather.dart';

/// Model extending the [Weather] entity to support JSON parsing.
class WeatherModel extends Weather {
  const WeatherModel({
    required super.cityName,
    required super.temperatureKelvin,
  });

  /// Creates a [WeatherModel] from JSON.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final double tempKelvin = (json['main']['temp'] as num).toDouble();
    final String name = json['name'] as String;
    return WeatherModel(
      cityName: name,
      temperatureKelvin: tempKelvin,
    );
  }
}
