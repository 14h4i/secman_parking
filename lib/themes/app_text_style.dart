import 'package:flutter/material.dart';

class AppTextStyle {
  //Common
  static const largeTitleCard = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 100,
  );

  static const h2 = TextStyle(
    fontSize: 90,
    fontWeight: FontWeight.w900,
    color: Colors.white,
  );

  static const h3 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
  );

  static const italic = TextStyle(
    fontStyle: FontStyle.italic,
  );

  //Card
  static const vehicleOwnerCard = TextStyle(
    color: Colors.white,
    fontSize: 50,
    fontWeight: FontWeight.bold,
  );

  static const dateTimeCard = TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.italic,
    fontSize: 25,
  );

  static const uidCard = TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.italic,
    fontSize: 20,
  );

  //History
  static const headingTable = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const vehicleNumberHistory = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w900,
  );

  static const dateTimeHistory = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
