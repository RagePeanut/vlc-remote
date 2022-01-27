import 'package:flutter/material.dart';

import '../../utils/regex.dart';
import '../../utils/sizer.dart';

class TimeIndicator extends StatelessWidget {
    TimeIndicator({
        @required this.time,
    });

    final int time;

    @override
    Widget build(BuildContext context) {
        Duration duration = Duration(seconds: time);
        return Text(
            duration.toString().replaceFirst(zeroHourRegex, "").split(".")[0],
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: Sizer.fontSize(9.0),
            ),
        );
    }
}