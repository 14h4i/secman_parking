import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/route/route_name.dart';
import 'package:secman_parking/themes/app_text_style.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AutoSizeText(
              'WELCOME',
              maxLines: 1,
              style: AppTextStyle.largeTitleCard.copyWith(color: Colors.blue),
            ),
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: AutoSizeText(
                  'Bắt đầu',
                  maxLines: 1,
                  style: AppTextStyle.h3,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteName.loginPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
