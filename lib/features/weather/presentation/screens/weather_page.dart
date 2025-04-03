import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/weather_bloc/weather_bloc.dart';
import '../widgets/responsive_weather_image.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = context.read<WeatherBloc>();    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const ResponsiveWeatherImage(),
              const SizedBox(height: 24),
              Text(
                'THIS IS MY WEATHER APP',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Expanded(
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is WeatherLoaded) {
                      final double temperatureKelvin =
                          state.weather.temperatureKelvin;
                      final double temperature = state.isFahrenheit
                          ? _toFahrenheit(temperatureKelvin)
                          : _toCelsius(temperatureKelvin);
                
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          Text(
                            'Temperature',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            '${temperature.toStringAsFixed(0)} degrees',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Location',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            state.weather.cityName,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Celsius/Fahrenheit',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(width:16),
                                Switch(
                                  value: state.isFahrenheit,
                                  onChanged: (_) => context.read<WeatherBloc>().add(ToggleUnitEvent()),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (state is WeatherError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric( vertical: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      weatherBloc.add(LoadWeatherEvent());
                    },
                    child: Text(
                      'Refresh',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _toCelsius(double kelvin) => kelvin - 273.15;
  double _toFahrenheit(double kelvin) => (kelvin - 273.15) * 9 / 5 + 32;
}
