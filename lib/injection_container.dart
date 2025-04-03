// lib/injection_container.dart
import 'package:get/get.dart';

import 'features/weather/data/datasources/weather_remote_datasource.dart';
import 'features/weather/data/respositories/weather_repository_impl.dart';
import 'features/weather/domain/usecases/get_weather.dart';
import 'features/weather/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

void initDependencies() {
  // Data Source registration.
  Get.lazyPut<WeatherRemoteDataSourceImpl>(
      () => WeatherRemoteDataSourceImpl(client: Get.find<http.Client>()));

  // Repository registration with dependency injection.
  Get.lazyPut<WeatherRepositoryImpl>(
      () => WeatherRepositoryImpl(Get.find<WeatherRemoteDataSourceImpl>()));

  // Use Case registration.
  Get.lazyPut<GetWeather>(() => GetWeather(Get.find<WeatherRepositoryImpl>()));

  // BLoC registration.
  Get.lazyPut<WeatherBloc>(() => WeatherBloc(Get.find<GetWeather>()));

  Get.put<http.Client>(http.Client());
}
