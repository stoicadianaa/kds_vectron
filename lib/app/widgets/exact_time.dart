import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kds_vectron/core/extensions/date_time_extension.dart';

class ExactTime extends StatelessWidget {
  ExactTime({super.key, this.style}) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      time.value = DateTime.now();
    });
  }

  final ValueNotifier<DateTime> time = ValueNotifier(DateTime.now());
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: time,
      builder: (context, DateTime value, child) {
        return Text(value.formattedTime);
      },
    );
  }
}
