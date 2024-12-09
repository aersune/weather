

import 'package:flutter/cupertino.dart';

class WeatherProvider extends ChangeNotifier{
  String bgImage = 'assets/day.png';
  final DateTime now = DateTime.now();
    bool bgChanged = false;
   ValueNotifier<String> bgImageNotifier = ValueNotifier('assets/day.png');
  int sunrise = 0;
  int sunset = 0;




  String getBackgroundImage(DateTime sunrise, DateTime sunset) {
    if (now.isAfter(sunrise) && now.isBefore(sunset)) {
      return 'assets/day.png';
    } else if (now.isAfter(sunrise.subtract(const Duration(hours: 1))) &&
        now.isBefore(sunrise.add(const Duration(hours: 1)))) {
      return 'assets/sunset.png';
    } else if (now.isAfter(sunset.subtract(const Duration(hours: 1))) &&
        now.isBefore(sunset.add(const Duration(hours: 1)))) {
      return 'assets/sunset.png';
    } else {
      return 'assets/night.png';
    }
  }



  void updateBackgroundImage() {
    DateTime sunRise = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    DateTime sunSet = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);


    bgImageNotifier.value = getBackgroundImage(sunRise, sunSet);
    bgChanged = true;
    print('update image');


    notifyListeners();
  }
}