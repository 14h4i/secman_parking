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
        const SizedBox(height: 20),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(
              width: 9,
              color: Colors.white,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AutoSizeText(
                    card.subVehicle!,
                    maxLines: 1,
                    style: AppTextStyle.largeTitleCard,
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    card.vehicleNumber!,
                    maxLines: 1,
                    style: AppTextStyle.largeTitleCard,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                card.vehicleOwner!,
                maxLines: 1,
                style: AppTextStyle.vehicleOwnerCard,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AutoSizeText(
                    'Đơn vị: ${card.unit!}',
                    maxLines: 1,
                    style: AppTextStyle.uidCard,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              AutoSizeText(
                'Mã thẻ: ${card.id!}',
                maxLines: 1,
                style: AppTextStyle.dateTimeCard,
              ),
              const SizedBox(width: 20),
              // Spacer(),
              AutoSizeText(
                'Loại xe: ${card.vehicleType!}',
                maxLines: 1,
                style: AppTextStyle.dateTimeCard,
              ),
              AutoSizeText(
                'SĐT: ${card.phoneNumber!}',
                maxLines: 1,
                style: AppTextStyle.dateTimeCard,
              ),
              const SizedBox(height: 20),
              AutoSizeText(
                'Trước đó: ${DateTimeIntl.dateTimeToString(card.previousTime!)}',
                maxLines: 1,
                style: AppTextStyle.dateTimeCard,
              ),
              AutoSizeText(
                'Hiện tại: ${DateTimeIntl.dateTimeToString(card.currentTime!)}',
                maxLines: 1,
                style: AppTextStyle.dateTimeCard,
              ),
              // const SizedBox(height: 40),
              // AutoSizeText(
              //   !card.gotInto! ? 'RA' : 'VÀO',
              //   maxLines: 1,
              //   style: AppTextStyle.largeTitleCard,
              // ),
            ],
          ),
        )
      ],
    );
  }
}
