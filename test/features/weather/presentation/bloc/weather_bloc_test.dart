import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:my_weather_app/features/weather/domain/entities/weather.dart';
import 'package:my_weather_app/features/weather/domain/usecases/get_weather.dart';
import 'package:my_weather_app/features/weather/presentation/bloc/weather_bloc/weather_bloc.dart';

import 'weather_bloc_test.mocks.dart';

@GenerateMocks([GetWeather])
void main() {
  late WeatherBloc weatherBloc;
  late MockGetWeather mockGetWeather;

  setUp(() {
    mockGetWeather = MockGetWeather();
    weatherBloc = WeatherBloc(mockGetWeather);
  });

  tearDown(() {
    weatherBloc.close();
  });

  const testWeather = Weather(
    cityName: 'London',
    temperatureKelvin: 280.32,
  );

  group('LoadWeatherEvent', () {
    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoaded] when successful',
      build: () {
        when(mockGetWeather(any, any)).thenAnswer((_) async => testWeather);
        return weatherBloc;
      },
      act: (bloc) => bloc.add(LoadWeatherEvent()),
      expect: () => [
        WeatherLoading(),
        const WeatherLoaded(weather: testWeather, isFahrenheit: false),
      ],
      verify: (_) {
        verify(mockGetWeather(any, any)).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherError] when failed',
      build: () {
        when(mockGetWeather(any, any)).thenThrow(Exception('Failed to load'));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(LoadWeatherEvent()),
      expect: () => [
        WeatherLoading(),
        WeatherError('Exception: Failed to load'),
      ],
      verify: (_) {
        verify(mockGetWeather(any, any)).called(1);
      },
    );
  });

  group('ToggleUnitEvent', () {
    blocTest<WeatherBloc, WeatherState>(
      'should toggle temperature unit when in loaded state',
      build: () => weatherBloc,
      seed: () => const WeatherLoaded(
        weather: testWeather,
        isFahrenheit: false,
      ),
      act: (bloc) => bloc.add(ToggleUnitEvent()),
      expect: () => [
        const WeatherLoaded(
          weather: testWeather,
          isFahrenheit: true,
        ),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'should not change state when not in loaded state',
      build: () => weatherBloc,
      seed: () => WeatherInitial(),
      act: (bloc) => bloc.add(ToggleUnitEvent()),
      expect: () => [],
    );
  });
}
