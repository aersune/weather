import 'package:flutter/material.dart';
import 'package:weather/utilities/forecast_util.dart';

import '../model/weather_forecast_daily.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const CityView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var city = snapshot.data?.city?.name;
    var country = snapshot.data?.city?.country;
    var formattedDate = DateTime.fromMillisecondsSinceEpoch(forecastList![0].dt! * 1000);
    return Column(
      children: [
        Text(
          '$city,  $country',
          style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
        const SizedBox(height: 10,),
        Text(
          Util.getFotmatattedDate(formattedDate) ,
            style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
