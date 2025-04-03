part of 'weather_bloc.dart';

abstract class WeatherEvent {}

/// Event to load or refresh weather data.
class LoadWeatherEvent extends WeatherEvent {}

class ToggleUnitEvent extends WeatherEvent {}
