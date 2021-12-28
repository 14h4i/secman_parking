import 'package:flutter/material.dart';
import 'package:secman_parking/common/widgets/stateless/text_time_in_out.dart';

class TimeInOut extends StatelessWidget {
  final DateTime? timeIn;
  final DateTime? timeOut;
  final bool isIn;

  const TimeInOut({
    Key? key,
    required this.isIn,
    required this.timeIn,
    required this.timeOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: isIn
          ? [
              TextTimeInOut(
                isIn: false,
                time: timeOut,
              ),
              TextTimeInOut(
                isIn: true,
                time: timeIn,
              ),
            ]
          : [
              TextTimeInOut(
                isIn: true,
                time: timeIn,
              ),
              TextTimeInOut(
                isIn: false,
                time: timeOut,
              ),
            ],
    );
  }
}
