import 'package:flutter/material.dart';
import 'package:forecast_app/core/exceptions/exceptions.dart';
import 'package:forecast_app/services/weather_service.dart';

class MyWeatherPage extends StatelessWidget {
  final service = WeatherService();
  MyWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('El Clima'),
      ),
      body: FutureBuilder(
        future: service.getWeatherByLatLon(-16.416484, -71.535235),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              final error = snapshot.error;
              if (error is InvalidApiKeyException) {
                return const Text('Su api key es invalida');
              } else if (error is NothingToGeocodeException) {
                return const Text('Los datos proporcionados son invalidos');
              }
            }

            final data = snapshot.data;

            if (data != null) {
              return Column(
                children: [Text('${data.temperatureData.temp}')],
              );
            }
          }

          return const Text('Ocurrio un error inesperado');
        },
      ),
    );
  }
}
