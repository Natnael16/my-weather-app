import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_weather_app/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:my_weather_app/features/weather/data/models/weather_model.dart';
import 'package:my_weather_app/features/weather/data/respositories/weather_repository_impl.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([WeatherRemoteDataSource])
void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    repository = WeatherRepositoryImpl(mockRemoteDataSource);
  });

  const testLat = 51.5149;
  const testLon = -0.1236;
  const testWeatherModel =  WeatherModel(
    cityName: 'London',
    temperatureKelvin: 280.32,
  );

  test('should return Weather when data source succeeds', () async {
    // Arrange
    when(mockRemoteDataSource.fetchWeather(testLat, testLon))
        .thenAnswer((_) async => testWeatherModel);

    // Act
    final result = await repository.getWeather(testLat, testLon);

    // Assert
    expect(result, equals(testWeatherModel));
    verify(mockRemoteDataSource.fetchWeather(testLat, testLon));
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('should propagate errors from data source', () async {
    // Arrange
    when(mockRemoteDataSource.fetchWeather(testLat, testLon))
        .thenThrow(Exception('Failed to fetch'));

    // Act & Assert
    expect(() => repository.getWeather(testLat, testLon), throwsException);
    verify(mockRemoteDataSource.fetchWeather(testLat, testLon));
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
