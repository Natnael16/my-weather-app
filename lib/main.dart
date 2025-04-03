import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'core/theme.dart';
import 'features/weather/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'features/weather/presentation/screens/weather_page.dart';
import 'injection_container.dart';
void main() async {
  // Initialize dependencies.
  initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the WeatherBloc from GetX.
    final weatherBloc = Get.find<WeatherBloc>();
    // Trigger the initial weather load.
    weatherBloc.add(LoadWeatherEvent());

    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: BlocProvider.value(
        value: weatherBloc,
        child: const WeatherPage(),
      ),
    );
  }
}
