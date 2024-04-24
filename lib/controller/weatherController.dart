class WeatherController {
  // weather animations
  String getWeatherinArabic(String? mainCondition) {
    if (mainCondition == null) return 'طقس مشمس'; // default to sunny

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'طقس غائم';
      case 'mist':
        return 'ضباب';
      case 'smoke':
        return 'دخان';
      case 'haze':
        return 'ضباب خفيف';
      case 'dust':
        return 'عواصف رملية';
      case 'fog':
        return 'ضباب';
      case 'rain':
        return 'طقس ممطر';
      case 'drizzle':
        return 'ندى';
      case 'shower rain':
        return 'زخات مطر';
      case 'thunderstorm':
        return 'عواصف رعدية';
      case 'clear':
        return 'طقس صافٍ';
      case 'tornado':
        return 'عاصفة';
      case 'snow':
        return 'ثلج';
      default:
        print("/////////////////////////${mainCondition}");
        return 'طقس مشمس';
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'images/sunny.json'; // default to sunny

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'images/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'images/rain.json';
      case 'thunderstorm':
        return 'images/storm.json';
      case 'clear':
        return 'images/sunny.json';
      case 'snow':
        return 'images/snow.json';
      default:
        return 'images/sunny.json';
    }
  }
}
