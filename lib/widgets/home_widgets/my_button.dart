import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.widget}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        padding: const EdgeInsets.all(12),
        child:Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: widget,
          ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFEBF3FE),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF3F6080).withOpacity(.2),
                offset: const Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 3.0),
            const BoxShadow(
                color: Color(0xFFEBF3FE),
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFEBF3FE).withOpacity(0.4),
              const Color(0xFFEBF3FE).withOpacity(0.6),
              const Color(0xFFEBF3FE).withOpacity(0.8),
              const Color(0xFF3F6080).withOpacity(.2),
            ],
            stops: const [0.1, 0.3, 0.4, 1],
          ),
        ),
      ),
    );
  }
}
