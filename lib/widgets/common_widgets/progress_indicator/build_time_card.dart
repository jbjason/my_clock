import 'package:flutter/material.dart';

class BuildTimeCard extends StatelessWidget {
  const BuildTimeCard({Key? key, required this.time, required this.header})
      : super(key: key);
  final String time;
  final String header;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[500]!,
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 5.0),
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[200]!,
                  Colors.grey[400]!,
                  Colors.blue[300]!.withOpacity(0.5),
                ],
                stops: const [0.0, 0.55, 1],
              ),
            ),
            child: Text(
              time,
              style: const TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
          const SizedBox(height: 15),
          Text(header),
        ],
      ),
    );
  }
}
