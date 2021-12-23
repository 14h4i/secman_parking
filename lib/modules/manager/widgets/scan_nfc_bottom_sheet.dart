import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/utils/ui_data.dart';

class ScanNfcBottomSheet extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Function() onPressed;
  const ScanNfcBottomSheet({
    Key? key,
    required this.title,
    this.subTitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          AutoSizeText(
            title,
            maxLines: 1,
            style: const TextStyle(fontSize: 40, color: Colors.grey),
          ),
          // const SizedBox(height: 10),
          SizedBox(
            height: 250,
            width: 250,
            child: Image.asset(
              UIData.scanNfc,
            ),
          ),
          if (subTitle != null)
            AutoSizeText(
              subTitle!,
              maxLines: 1,
              style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
            ),
          // const SizedBox(height: 10),
          ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              child: Text(
                'Hủy',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            style: ElevatedButton.styleFrom(primary: Colors.grey),
            onPressed: onPressed,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
