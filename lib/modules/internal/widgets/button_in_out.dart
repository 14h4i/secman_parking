import 'package:flutter/material.dart';

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
        SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Text(
              'VÀO',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            onPressed: onPressedIn,
          ),
        ),
        const SizedBox(width: 80),
        SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            child: const Text(
              'RA',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            onPressed: onPressedOut,
          ),
        ),
      ],
    );
  }
}
