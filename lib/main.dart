import 'package:flutter/material.dart';
import 'package:openweather_api/models/api_base_helper.dart';
import 'package:openweather_api/models/weather_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<WeatherResponse> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = ApiBaseHelper();
  }

  void _reload() {
    setState(() {
      futureWeather = ApiBaseHelper();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A),
              Color(0xFF1E293B),
              Color(0xFF334155),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: FutureBuilder<WeatherResponse>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.cloud_off,
                            color: Colors.white, size: 60),
                        const SizedBox(height: 16),
                        const Text(
                          'Unable to load weather',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _reload,
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    'No weather data',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              final weather = snapshot.data!;

              return RefreshIndicator(
                onRefresh: () async {
                  _reload();
                  await futureWeather;
                },
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: _reload,
                          icon: const Icon(Icons.refresh, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${weather.cityName}, ${weather.country}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      weather.weather.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Image.network(
                        weather.iconUrl,
                        width: 110,
                        height: 110,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.cloud,
                            color: Colors.white,
                            size: 80,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        '${weather.temp.round()}°',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 88,
                          fontWeight: FontWeight.w300,
                          height: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Feels like ${weather.feelsLike.round()}°C',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          _weatherRow(
                            'Humidity',
                            '${weather.humidity}%',
                          ),
                          const Divider(color: Colors.white24),
                          _weatherRow(
                            'Wind speed',
                            '${weather.windSpeed} m/s',
                          ),
                          const Divider(color: Colors.white24),
                          _weatherRow(
                            'Pressure',
                            '${weather.pressure} hPa',
                          ),
                          const Divider(color: Colors.white24),
                          _weatherRow(
                            'Visibility',
                            '${(weather.visibility / 1000).toStringAsFixed(1)} km',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _weatherRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}