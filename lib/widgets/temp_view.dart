import 'package:flutter/material.dart';

import '../model/weather_forecast_daily.dart';

class TempView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const TempView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var icon = forecastList?[0].getIconUrl();
    var temp = forecastList?[0].temp?.day?.toStringAsFixed(0);
    var description = forecastList?[0].weather?[0].description?.toUpperCase();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Image.network(
         icon!,
         scale: 0.7,
         color: Colors.white,
       ),

        Column(
          children: [
            Text(
              '$temp °C',
              style: const TextStyle(fontSize: 54, color: Colors.white, fontWeight: FontWeight.w300),
            ),
            Text(description.toString(), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),)
          ],
        )
      ],
    );
  }
}
