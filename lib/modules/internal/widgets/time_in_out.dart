import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/themes/app_text_style.dart';
import 'package:secman_parking/utils/date_time_intl.dart';

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
              AutoSizeText(
                'Ra: ${timeOut != null ? DateTimeIntl.dateTimeToString(timeOut!) : ''}',
                maxLines: 1,
                style:
                    AppTextStyle.dateTimeCard.copyWith(color: Colors.redAccent),
              ),
              AutoSizeText(
                'Vào: ${timeIn != null ? DateTimeIntl.dateTimeToString(timeIn!) : ''}',
                maxLines: 1,
                style: AppTextStyle.dateTimeCard
                    .copyWith(color: Colors.greenAccent),
              ),
            ]
          : [
              AutoSizeText(
                'Vào: ${timeIn != null ? DateTimeIntl.dateTimeToString(timeIn!) : ''}',
                maxLines: 1,
                style: AppTextStyle.dateTimeCard
                    .copyWith(color: Colors.greenAccent),
              ),
              AutoSizeText(
                'Ra: ${timeOut != null ? DateTimeIntl.dateTimeToString(timeOut!) : ''}',
                maxLines: 1,
                style:
                    AppTextStyle.dateTimeCard.copyWith(color: Colors.redAccent),
              ),
            ],
    );
  }
}
