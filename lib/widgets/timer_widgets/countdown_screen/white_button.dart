import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  const WhiteButton({Key? key, required this.text, required this.isTrue})
      : super(key: key);
  final String text;
  final bool isTrue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding:const EdgeInsets.all( 40.0),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, letterSpacing: 1.2),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 3,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}
