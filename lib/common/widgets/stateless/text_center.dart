import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/themes/app_text_style.dart';

class TextCenter extends StatelessWidget {
  final String content;
  const TextCenter({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        content,
        maxLines: 1,
        style: AppTextStyle.largeTitleCard,
      ),
    );
  }
}
