import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/models/card.dart' as crd;
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
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 100,
              ),
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
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                ),
              ),
              const AutoSizeText(
                'Người tòa nhà',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (card.timeIn != null)
                AutoSizeText(
                  'Vào: ${DateTimeIntl.dateTimeToString(card.timeIn!)}',
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 25,
                  ),
                ),
              if (card.timeOut != null)
                AutoSizeText(
                  'Ra: ${DateTimeIntl.dateTimeToString(card.timeOut!)}',
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 25,
                  ),
                ),
              const SizedBox(height: 40),
              Icon(
                card.timeIn == null ? Icons.arrow_downward : Icons.arrow_upward,
                size: 150,
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    );
  }
}
