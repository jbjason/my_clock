import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: kToolbarHeight + 30,
          padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'Alarm ',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF616161)),
              ),
              Spacer(),
              Icon(CupertinoIcons.add, size: 22)
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                     bottom: 15, right: 15, left: 15),
                child: Container(
                  height: 140,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Title Text'),
                          SizedBox(height: 8),
                          Text(
                            "12:60",
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Every Day'),
                          CupertinoSwitch(
                              value: _isOn,
                              activeColor: Colors.blueGrey[400],
                              trackColor: Colors.blueGrey[200],
                              onChanged: (val) =>
                                  setState(() => _isOn = !_isOn))
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    // color: const Color(0xFFEBF3FE),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
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
                        const Color(0xFF3F6080).withOpacity(0.3),
                        const Color(0xFF3F6080).withOpacity(.2),
                        const Color(0xFF3F6080).withOpacity(.2),
                        const Color(0xFF3F6080).withOpacity(0.3),
                      ],
                      stops: const [0.0, 0.3, 0.6, 1],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

final decoration = BoxDecoration(
  // color: const Color(0xFFEBF3FE),
  color: Colors.grey[300],
  borderRadius: BorderRadius.circular(20),
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
      const Color(0xFF3F6080).withOpacity(0.4),
      const Color(0xFF3F6080).withOpacity(.2),
      const Color(0xFF3F6080).withOpacity(.2),
      const Color(0xFF3F6080).withOpacity(0.4),
    ],
    stops: const [0.0, 0.3, 0.6, 1],
  ),
);