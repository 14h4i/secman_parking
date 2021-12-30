import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/utils/number_intl.dart';

class AnimatedCouter extends StatelessWidget {
  final int value;
  final String sym;
  final bool isMoney;
  final Duration duration;
  final TextStyle? textStyle;

  const AnimatedCouter(
      {Key? key,
      required this.value,
      this.sym = '',
      this.duration = const Duration(seconds: 1),
      this.textStyle,
      this.isMoney = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: IntTween(begin: 0, end: value),
      duration: duration,
      builder: (context, int value, child) => AutoSizeText(
        value != 0
            ? isMoney
                ? '${NumberIntl.formatMoney(value)}$sym'
                : '$value$sym'
            : '$value',
        maxLines: 1,
        style: textStyle,
      ),
    );
  }
}
