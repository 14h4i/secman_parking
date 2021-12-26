import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/themes/app_text_style.dart';

class TextError extends StatelessWidget {
  final Object? error;
  const TextError({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        'Error: $error',
        maxLines: 1,
        style: AppTextStyle.largeTitleCard,
      ),
    );
  }
}
