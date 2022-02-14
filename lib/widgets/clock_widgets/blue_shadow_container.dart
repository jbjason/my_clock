import 'package:flutter/material.dart';

class BlueShadowContainer extends StatelessWidget {
  const BlueShadowContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3F6080).withOpacity(.2),
            blurRadius: 32,
            offset: const Offset(40, 20),
          ),
          BoxShadow(
            color: const Color(0xFFFFFFFF).withOpacity(1),
            blurRadius: 32,
            offset: const Offset(-20, -10),
          ),
        ],
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFFECF6FF), Color(0xFFCADBEB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}