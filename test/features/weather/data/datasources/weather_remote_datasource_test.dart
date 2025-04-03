import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather_app/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:my_weather_app/features/weather/data/models/weather_model.dart';
import 'dart:convert';

import 'weather_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late WeatherRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;
  const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  const testApiKey = 'test_api_key';

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = WeatherRemoteDataSourceImpl(
      client: mockHttpClient,
      apiKey: testApiKey,
      baseUrl: baseUrl,
    );
  });

  test('should return WeatherModel when response code is 200', () async {
    // Arrange
    const lat = 51.5149;
    const lon = -0.1236;
    final mockResponse = {
      'weather': [
        {'description': 'clear sky'}
      ],
      'main': {'temp': 280.32},
      'name': 'London',
    };

    when(mockHttpClient
            .get(Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$testApiKey')))
        .thenAnswer((_) async => http.Response(json.encode(mockResponse), 200));

    // Act
    final result = await dataSource.fetchWeather(lat, lon);

    // Assert
    expect(result, isA<WeatherModel>());
    expect(result.cityName, 'London');
    expect(result.temperatureKelvin, 280.32);
    verify(mockHttpClient
        .get(Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$testApiKey')));
  });

  test('should throw exception on non-200 response', () async {
    // Arrange
    const lat = 51.5149;
    const lon = -0.1236;

    when(mockHttpClient
            .get(Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$testApiKey')))
        .thenAnswer((_) async => http.Response('Not Found', 404));

    // Act & Assert
    expect(() => dataSource.fetchWeather(lat, lon), throwsException);
    verify(mockHttpClient
        .get(Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$testApiKey')));
  });

  test('should handle network errors', () async {
    // Arrange
    const lat = 51.5149;
    const lon = -0.1236;

    when(mockHttpClient
            .get(Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$testApiKey')))
        .thenThrow(http.ClientException('Network Error'));

    // Act & Assert
    expect(() => dataSource.fetchWeather(lat, lon), throwsException);
  });

  test('should throw exception on invalid JSON', () async {
    // Arrange
    const lat = 51.5149;
    const lon = -0.1236;

    when(mockHttpClient
            .get(Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$testApiKey')))
        .thenAnswer((_) async => http.Response('Invalid JSON', 200));

    // Act & Assert
    expect(() => dataSource.fetchWeather(lat, lon), throwsException);
    verify(mockHttpClient
        .get(Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$testApiKey')));
  });
}
