import 'package:flutter/material.dart';

class BuildTimeCard extends StatelessWidget {
  const BuildTimeCard({Key? key, required this.time, required this.header})
      : super(key: key);
  final String time;
  final String header;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            time,
            style: const TextStyle(color: Colors.black, fontSize: 30),
          ),
        ),
        const SizedBox(height: 15),
        Text(header),
      ],
    );
  }
}
