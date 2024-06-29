import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tool_box_pro/utils/styles.dart';
import 'package:tool_box_pro/components/bottom_bar.dart';
import 'package:tool_box_pro/components/top_menu.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Map<String, dynamic>? _weatherData;
  bool _loading = false;
  bool _isMinimized = false;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _loading = true;
    });

    const apiKey = '4abff981ad98d695e71ff3c2ed82b60c';
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Dominican%20Republic&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _weatherData = data;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  void _onMinimize() {
    setState(() {
      _isMinimized = true;
    });
  }

  void _onRestore() {
    setState(() {
      _isMinimized = false;
    });
  }

  void _onClose() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopMenu(
            title: 'Clima en RD',
            isLoading: _loading,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _isMinimized
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.aspect_ratio, size: 50),
                              color: primaryColor,
                              onPressed: _onRestore,
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: _onRestore,
                              child: const Text('Restaurar',
                                  style: TextStyle(
                                      fontSize: 16, color: textColor)),
                            ),
                            TextButton(
                              onPressed: _onClose,
                              child: const Text('Cerrar',
                                  style: TextStyle(
                                      fontSize: 16, color: textColor)),
                            ),
                          ],
                        ),
                      )
                    : _weatherData == null
                        ? const Center(
                            child: Text(
                              'No se pudo obtener la información del clima',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Clima en República Dominicana',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Temperatura: ${_weatherData!['main']['temp']}°C',
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Estado: ${_weatherData!['weather'][0]['description']}',
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Image.network(
                                'http://openweathermap.org/img/wn/${_weatherData!['weather'][0]['icon']}@2x.png',
                              ),
                            ],
                          ),
              ),
            ),
          ),
          BottomBar(
            onMinimize: _onMinimize,
            onRestore: _onRestore,
            onClose: _onClose,
          ),
        ],
      ),
    );
  }
}
