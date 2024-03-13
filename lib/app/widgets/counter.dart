import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kds_vectron/core/extensions/duration_extension.dart';

class Counter extends StatefulWidget {
  final DateTime startTime;
  final TextStyle? style;

  const Counter({super.key, this.style, required this.startTime});

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  late final ValueNotifier<Duration> duration;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    duration = ValueNotifier(DateTime.now().difference(widget.startTime));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        duration.value = DateTime.now().difference(widget.startTime);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: duration,
      builder: (context, Duration value, child) {
        return Text(
          duration.value.formattedDuration,
          style: widget.style,
        );
      },
    );
  }
}
