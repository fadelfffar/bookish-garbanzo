class Weather {
  final int id;
  final String main;
  final String  description;
  final String  icon;

  Weather(
      {
        required this.id, required this.main, required this.description, required this.icon,
      }
      );
  factory Weather.fromJson(Map<String, dynamic> json) {
    final weatherJson = json['weather'][0];
    return Weather(
      id : weatherJson['id'],
      main: weatherJson['weather'][0]['main'],
      description: weatherJson['weather'][0]['description'],
      icon: weatherJson['weather'][0]['icon'],
    );
  }
}