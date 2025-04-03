// lib/presentation/bloc/weather_state.dart
part of 'weather_bloc.dart';

/// Base class for weather states.
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

/// Initial state before data is loaded.
class WeatherInitial extends WeatherState {}

/// State while loading weather data.
class WeatherLoading extends WeatherState {}

/// Loaded state containing the weather data and unit flag.
class WeatherLoaded extends WeatherState {
  final Weather weather;
  final bool isFahrenheit;

  const WeatherLoaded({required this.weather, required this.isFahrenheit});

  @override
  List<Object?> get props => [weather, isFahrenheit];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
