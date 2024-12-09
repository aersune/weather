import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util{
  static String getFotmatattedDate(DateTime dateTime){
    return DateFormat('EEE, MMM d, y').format(dateTime);
  }

  static getItem(IconData iconData, int value, String units){
    return Column(
      children: [
        Icon(iconData, color: Colors.white, size: 24,),
        const SizedBox(height: 10,),
        Text(value.toString(), style: const TextStyle(fontSize: 20, color: Colors.white),),
        const SizedBox(height: 10,),
        Text(units, style: const TextStyle(fontSize: 15, color: Colors.white),),
      ],
    );
  }
}