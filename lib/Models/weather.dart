class Weatherr {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weatherr({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  factory Weatherr.fromJson(Map<String, dynamic> json) {
    return Weatherr(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}
