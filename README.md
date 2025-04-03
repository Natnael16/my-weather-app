# My Weather App ☀️

A single-screen Flutter weather app demonstrating Clean Architecture, BLoC for state management, and GetX for dependency injection. The app fetches real-time weather data from the OpenWeatherMap API, displays it in a user-friendly UI, and allows users to toggle between Fahrenheit and Celsius. Additionally, it includes a refresh functionality to update the weather information.

## Features
- Fetch real-time weather data from OpenWeatherMap API
- Clean architecture with Domain, Data, and Presentation layers
- State management using BLoC
- Dependency injection handled with GetX
- Unit tests covering Data Source, Repository, Use Case, and BLoC
- Temperature toggle between Fahrenheit and Celsius
- Refresh functionality to get the latest weather data

## Getting Started

### Prerequisites
- Ensure you have Flutter SDK: `>=3.4.4 and <4.0.0`
- Install dependencies by running:
  ```sh
  flutter pub get
  ```
- Create a `.env` file in the root directory and add your OpenWeatherMap API key:
  ```sh
  WEATHER_API_KEY=your_api_key_here
  ```

### Running the App
To start the application, use the following command:
```sh
flutter run
```

### Running Tests
To execute unit tests, run:
```sh
flutter test
```

## Architecture Overview
This project follows Clean Architecture principles, ensuring maintainability and scalability. The structure is divided into three main layers:

1. **Data Layer**: Handles API requests and data transformations.
2. **Domain Layer**: Contains business logic and use cases.
3. **Presentation Layer**: Manages UI and state with BLoC.

## UI Preview
![image](https://github.com/user-attachments/assets/dff64640-bfee-424b-a870-6930e0a2d377)

## Dependencies
The key dependencies used in this project include:
- `flutter_bloc` for state management
- `get_it` for dependency injection
- `flutter_dotenv` for environment variables


