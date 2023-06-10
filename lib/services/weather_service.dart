import 'package:forecast_app/core/exceptions/exceptions.dart';
import 'package:forecast_app/core/networking/networking.dart';
import 'package:forecast_app/models/weather_response.dart';
import 'package:geolocator/geolocator.dart';

class WeatherService {
  Future<WeatherResponse> getWeatherByLatLon() async {
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isServiceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          throw LocationPermissionDeniedException();
        }
      }

      if (permission == LocationPermission.unableToDetermine) {
        throw LocationUndeterminedException();
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        final networking = Networking();
        final currentPosition = await Geolocator.getCurrentPosition();
        final response = await networking.get(operationPath: '', params: {
          'lat': currentPosition.latitude,
          'lon': currentPosition.longitude,
          'units': 'metric',
        });

        return WeatherResponse.fromJson(response);
      }

      throw LocationException();
    } else {
      throw LocationServiceException();
    }
  }
}
