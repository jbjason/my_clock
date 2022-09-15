import 'package:flutter/material.dart';

BoxDecoration alarmListDecoration(bool isSelected) => BoxDecoration(
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
      gradient: isSelected
          ? LinearGradient(colors: [Colors.grey[500]!, Colors.grey[600]!])
          : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFEBF3FE),
                Colors.grey[200]!,
                Colors.grey[300]!,
                Colors.grey[400]!,
              ],
              stops: const [0.1, 0.4, 0.7, 1],
            ),
    );
