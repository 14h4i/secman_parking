import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AnimatedCouter extends StatelessWidget {
  final int value;
  final String sym;
  final Duration duration;
  final TextStyle? textStyle;

  const AnimatedCouter({
    Key? key,
    required this.value,
    this.sym = '',
    this.duration = const Duration(seconds: 1),
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: IntTween(begin: 0, end: value),
      duration: duration,
      builder: (context, value, child) => AutoSizeText(
        value != 0 ? '$value$sym' : '$value',
        style: textStyle,
      ),
    );
  }
}
