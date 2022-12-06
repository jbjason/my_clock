import 'package:flutter/material.dart';

class NameAndWeather extends StatelessWidget {
  const NameAndWeather({Key? key, required this.weather}) : super(key: key);
  final String weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(weather, style: const TextStyle(fontSize: 25)),
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
  }
}
