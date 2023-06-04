class TemperatureData {
  final double temp;
  final double feelsLike;

  TemperatureData({
    required this.temp,
    required this.feelsLike,
  });

  factory TemperatureData.fromJson(Map<String, dynamic> json) {
    return TemperatureData(
      temp: json['temp'],
      feelsLike: json['feels_like'],
    );
  }
}
