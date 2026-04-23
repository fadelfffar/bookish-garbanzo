class WeatherResponse {
  final String cityName;
  final String country;
  final double temp;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final int visibility;
  final double windSpeed;
  final int cloudiness;
  final int timezone;
  final int dt;
  final Weather weather;

  WeatherResponse({
    required this.cityName,
    required this.country,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.visibility,
    required this.windSpeed,
    required this.cloudiness,
    required this.timezone,
    required this.dt,
    required this.weather,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      cityName: json['name'] ?? '',
      country: json['sys']['country'] ?? '',
      temp: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      pressure: json['main']['pressure'] as int,
      visibility: json['visibility'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      cloudiness: json['clouds']['all'] as int,
      timezone: json['timezone'] as int,
      dt: json['dt'] as int,
      weather: Weather.fromJson(json),
    );
  }

  String get iconUrl =>
      'https://openweathermap.org/img/wn/${weather.icon}@2x.png';

  double get tempCelsius => temp - 273.15;
  double get feelsLikeCelsius => feelsLike - 273.15;
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weatherJson = json['weather'][0];

    return Weather(
      id: weatherJson['id'] as int,
      main: weatherJson['main'] as String,
      description: weatherJson['description'] as String,
      icon: weatherJson['icon'] as String,
    );
  }
}