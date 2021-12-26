import 'package:flutter/material.dart';

class FloatingTextButton extends StatelessWidget {
  final String content;
  final Color backgroundColor;
  const FloatingTextButton({
    Key? key,
    required this.onPressedIn,
    required this.content,
    this.backgroundColor = Colors.blue,
  }) : super(key: key);

  final Function()? onPressedIn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: FloatingActionButton(
        backgroundColor: backgroundColor,
        child: Text(
          content,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        onPressed: onPressedIn,
      ),
    );
  }
}
