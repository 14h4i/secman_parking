import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/models/card.dart' as crd;
import 'package:secman_parking/themes/app_text_style.dart';
import 'package:secman_parking/utils/date_time_intl.dart';

class InfoCardInternal extends StatelessWidget {
  final crd.Card card;

  const InfoCardInternal({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: AutoSizeText(
              card.vehicleNumber!,
              maxLines: 1,
              style: AppTextStyle.largeTitleCard,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                'Mã thẻ: ${card.id!}',
                maxLines: 1,
                style: AppTextStyle.uidCard,
              ),
              AutoSizeText(
                card.vehicleOwner!,
                maxLines: 1,
                style: AppTextStyle.vehicleOwnerCard,
              ),
              AutoSizeText(
                  !card.gotInto!
                      ? 'Vào: ${DateTimeIntl.dateTimeToString(card.timeIn!)}'
                      : 'Ra: ${DateTimeIntl.dateTimeToString(card.timeOut!)}',
                  maxLines: 1,
                  style: AppTextStyle.dateTimeCard),
              AutoSizeText(
                !card.gotInto!
                    ? 'Ra: ${DateTimeIntl.dateTimeToString(card.timeOut!)}'
                    : 'Vào: ${DateTimeIntl.dateTimeToString(card.timeIn!)}',
                maxLines: 1,
                style: AppTextStyle.dateTimeCard,
              ),
              const SizedBox(height: 40),
              AutoSizeText(
                !card.gotInto! ? 'RA' : 'VÀO',
                maxLines: 1,
                style: AppTextStyle.largeTitleCard,
              ),
            ],
          ),
        )
      ],
    );
  }
}
