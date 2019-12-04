import 'dart:async';

import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  final Function onCountdownTap;

  CountdownWidget({this.onCountdownTap});

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer _timer;

  @override
  void initState() {
    _initTimer();
    super.initState();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _initTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        print('Timer tick: ${timer.tick}');
        if (timer.tick == 3) {
          widget.onCountdownTap();
        }
      },
    );
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.white70, width: 0.5),
        color: Color(0x88000000),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onCountdownTap,
          borderRadius: BorderRadius.circular(20.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
            child: Text(
              'Skip',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontFamily: "Source Code Pro"),
            ),
          ),
        ),
      ),
    );
  }
}
