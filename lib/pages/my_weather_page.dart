import 'package:flutter/material.dart';
import 'package:forecast_app/core/exceptions/exceptions.dart';
import 'package:forecast_app/services/weather_service.dart';
import 'package:geolocator/geolocator.dart';

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
        future: service.getWeatherByLatLon(),
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
              } else if (error is LocationServiceException) {
                return const Text('Habilita tu gps para usar esta funcion');
              } else {
                return Column(
                  children: [
                    const Text('Fallos al obtener tu ubicacion'),
                    ElevatedButton(
                      onPressed: () {
                        Geolocator.openAppSettings();
                      },
                      child: Text('Ir a configuracion de la app'),
                    ),
                  ],
                );
              }
            }

            final data = snapshot.data;

            if (data != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tu temperatura actual es: ${data.temperatureData.temp} C, con una sensacion de ${data.temperatureData.feelsLike} C',
                      style: const TextStyle(fontSize: 32),
                      textAlign: TextAlign.center,
                    ),
                    Text('${data.weatherDescription.description}')
                  ],
                ),
              );
            }
          }

          return const Text('Ocurrio un error inesperado');
        },
      ),
    );
  }
}
