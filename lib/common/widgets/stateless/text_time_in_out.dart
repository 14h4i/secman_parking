import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/themes/app_text_style.dart';
import 'package:secman_parking/utils/date_time_intl.dart';

class TextTimeInOut extends StatelessWidget {
  final DateTime? time;
  final bool isIn;

  const TextTimeInOut({
    Key? key,
    required this.time,
    required this.isIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      '${isIn ? 'Vào' : 'Ra'}: ${time != null ? DateTimeIntl.dateTimeToString(time!) : ''}',
      maxLines: 1,
      style: AppTextStyle.dateTimeCard
          .copyWith(color: isIn ? Colors.greenAccent : Colors.redAccent),
    );
  }
}
