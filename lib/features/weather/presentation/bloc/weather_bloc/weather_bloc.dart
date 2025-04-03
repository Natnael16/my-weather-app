// lib/presentation/bloc/weather_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/location.dart';
import '../../../domain/entities/weather.dart';
import '../../../domain/usecases/get_weather.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeatherUseCase;

  WeatherBloc(this.getWeatherUseCase) : super(WeatherInitial()) {
    on<LoadWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      try {
        const lat = defaultLocationLatitude;
        const lon = defaultLocationLongitude;

        final weather = await getWeatherUseCase(lat, lon);
        // Default unit is Celsius.
        emit(WeatherLoaded(weather: weather, isFahrenheit: false));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });

    on<ToggleUnitEvent>((event, emit) {
      if (state is WeatherLoaded) {
        final loadedState = state as WeatherLoaded;
        emit(WeatherLoaded(
          weather: loadedState.weather,
          isFahrenheit: !loadedState.isFahrenheit,
        ));
      }
    });
  }
}
  