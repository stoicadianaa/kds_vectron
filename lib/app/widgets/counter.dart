import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  Counter({super.key, this.style, required DateTime startTime}) {
    duration = ValueNotifier(DateTime.now().difference(startTime));
    log('Counter constructor called with $startTime');
    Timer.periodic(const Duration(seconds: 1), (timer) {
      duration.value = DateTime.now().difference(startTime);
    });
  }

  late final ValueNotifier<Duration> duration;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: duration,
      builder: (context, Duration value, child) {
        return Text(
          '${(value.inSeconds / 3600).floor().toString().padLeft(2, '0')}:${(value.inSeconds / 60 % 60).floor().toString().padLeft(2, '0')}:${(value.inSeconds % 60).toString().padLeft(2, '0')}',
          style: style,
        );
      },
    );
  }
}
