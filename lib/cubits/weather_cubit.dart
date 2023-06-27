import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/models/weather_response.dart';
import 'package:forecast_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService = WeatherService();

  WeatherCubit() : super(WeatherState());

  Future<void> getWeather() async {
    emit(WeatherState(isLoading: true));

    try {
      final weatherResponse = await weatherService.getWeatherByLatLon();

      emit(WeatherState(response: weatherResponse));
    } on Exception catch (e) {
      emit(WeatherState(exception: e));
    }
  }
}

class WeatherState {
  final bool isLoading;
  final Exception? exception;
  final WeatherResponse? response;

  WeatherState({this.isLoading = false, this.exception, this.response});
}
