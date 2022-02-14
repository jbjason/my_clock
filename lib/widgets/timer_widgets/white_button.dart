import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  const WhiteButton({Key? key, required this.text, required this.isTrue})
      : super(key: key);
  final String text;
  final bool isTrue;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
    width: 150,
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(isTrue ? 20 : 40.0),
      child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, letterSpacing: 1.2),
          ),
        ),
  
      decoration: BoxDecoration(
        color: Colors.grey[400],
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
