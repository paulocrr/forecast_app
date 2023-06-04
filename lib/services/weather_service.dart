import 'package:forecast_app/core/networking/networking.dart';
import 'package:forecast_app/models/weather_response.dart';

class WeatherService {
  Future<WeatherResponse> getWeatherByLatLon(double lat, double lon) async {
    final networking = Networking();

    final response = await networking.get(operationPath: '', params: {
      'lat': lat,
      'lon': lon,
      'units': 'metric',
    });

    return WeatherResponse.fromJson(response);
  }
}
