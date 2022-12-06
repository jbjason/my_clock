import 'package:flutter/material.dart';

class WhiteShadowContainer extends StatelessWidget {
  const WhiteShadowContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3F6080).withOpacity(.2),
            blurRadius: 32,
            offset: const Offset(10, 5),
          ),
          BoxShadow(
            color: const Color(0xFFFFFFFF).withOpacity(1),
            blurRadius: 32,
            offset: const Offset(-10, -5),
          ),
        ],
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFFE3F0F8), Color(0xFFEEF5FD)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
    );
  }
}
