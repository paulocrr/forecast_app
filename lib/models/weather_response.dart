import 'package:forecast_app/models/temperature_data.dart';
import 'package:forecast_app/models/weather_description.dart';

class WeatherResponse {
  final TemperatureData temperatureData;
  final WeatherDescription weatherDescription;

  WeatherResponse({
    required this.temperatureData,
    required this.weatherDescription,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final temperatureJson = json['main'];
    final weatherList = List.from(json['weather']);
    final weatherDescriptionJson = weatherList[0];

    return WeatherResponse(
      temperatureData: TemperatureData.fromJson(temperatureJson),
      weatherDescription: WeatherDescription.fromJson(weatherDescriptionJson),
    );
  }
}
