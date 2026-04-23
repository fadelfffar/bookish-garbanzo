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
      main: weatherJson['main'],
      description: weatherJson['description'],
      icon: weatherJson['icon'],
    );
  }
}