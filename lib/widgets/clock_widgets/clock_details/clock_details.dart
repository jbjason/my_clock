// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClockDetails extends StatefulWidget {
  const ClockDetails({Key? key}) : super(key: key);
  @override
  State<ClockDetails> createState() => _ClockDetailsState();
}

class _ClockDetailsState extends State<ClockDetails> {
  var temp, description, weather, humidiy, windSpeed;

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future getWeather() async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=dhaka&units=imperial&appid=40508fe785d7d926423d01cbacf7982d');
    final response = await http.get(url);
    final _responseBody = json.decode(response.body);
    if (_responseBody != null) {
      final _data = _responseBody as Map<String, dynamic>;
      temp = _data['main']['temp'];
      description = _data['weather'][0]['description'];
      weather = _data['weather'][0]['main'];
      humidiy = _data['main']['humidity'];
      windSpeed = _data['wind']['speed'];
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _temp = _getTemp(), _weather = _getWeather();
    final _wind = _getWind(), _humidity = _getHumidy();
    final _image = _getImage();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -20,
          top: -70,
          child: Image.asset('assets/$_image.png'),
        ),
        Column(
          children: [
            _nameAndWeather(_weather),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _weatherStatus('Wind', _wind),
                  const VerticalDivider(
                      color: Color.fromARGB(255, 156, 156, 184)),
                  _weatherStatus('Temp', _temp),
                  const VerticalDivider(
                      color: Color.fromARGB(255, 156, 156, 184)),
                  _weatherStatus('Humidity', _humidity),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherStatus(String title, String val) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(fontSize: 11)),
        Text(val, style: const TextStyle(fontSize: 25)),
      ],
    );
  }

  Widget _nameAndWeather(String weath) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(weath, style: const TextStyle(fontSize: 25)),
            Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(colors: [
                    Colors.white12,
                    Colors.white54,
                    Colors.white12,
                    Colors.white54
                  ])),
              child: const Text(
                'Dhaka',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );

  String _getTemp() => temp != null
      ? '${((temp - 32) * (5 / 9)).toStringAsFixed(1)}\u00B0'
      : '....';
  String _getWind() => windSpeed != null ? windSpeed.toString() : '....';
  String _getHumidy() => humidiy != null ? '$humidiy\u00B0' : '....';
  String _getWeather() => weather != null ? weather.toString() : '....';

  String _getImage() {
    final hour = DateTime.now().hour;
    final _hourImage = hour < 16
        ? 'sun'
        : hour < 20
            ? 'evening'
            : 'night';

    final String _image;
    if (weather != null) {
      _image = (weather.toString().startsWith('Ha') ||
              weather.toString().startsWith('Ra'))
          ? 'rain'
          : _hourImage;
    } else {
      _image = _hourImage;
    }
    return _image;
  }
}
