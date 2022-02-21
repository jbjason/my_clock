import 'package:flutter/material.dart';

class WheelItem extends StatelessWidget {
  const WheelItem(
      {Key? key,
      required this.i,
      required this.selectedText,
      required this.h,
      required this.m,
      required this.s})
      : super(key: key);
  final int i, h, m, s;
  final String selectedText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Center(
        // for minutes & seconds using 0(prefix) where its lower than 10
        child: Text(
          (selectedText == 's' || selectedText == 'm') && i < 10
              ? '0' + i.toString()
              : i.toString(),
          style: TextStyle(
            // if selected index second hoy & secondIndex current ==i then grey[900]
            color: selectedText == 's' && s == i ||
                    selectedText == 'm' && m == i ||
                    selectedText == 'h' && h == i
                ? Colors.grey[700]
                : Colors.grey[600],
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
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