import 'package:flutter/material.dart';
import 'package:secman_parking/common/widgets/stateless/floating_text_button.dart';

class ButtonInOut extends StatelessWidget {
  final Function()? onPressedIn;
  final Function()? onPressedOut;
  const ButtonInOut({
    Key? key,
    required this.onPressedIn,
    required this.onPressedOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FloatingTextButton(
          backgroundColor: Colors.green,
          content: 'VÀO',
          onPressedIn: onPressedIn,
        ),
        const SizedBox(width: 80),
        FloatingTextButton(
          backgroundColor: Colors.redAccent,
          content: 'RA',
          onPressedIn: onPressedOut,
        ),
      ],
    );
  }
}
