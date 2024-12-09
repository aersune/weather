import 'package:flutter/material.dart';
import 'package:weather/utilities/forecast_util.dart';
import '../model/weather_forecast_daily.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const DetailView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var pressure = 0.750062 * forecastList![0].pressure!;
    var humidity =  forecastList[0].humidity;
    var wind = forecastList[0].speed;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
          Util.getItem(FontAwesomeIcons.temperatureThreeQuarters, pressure.round(), 'mm Hg'),
          Util.getItem(FontAwesomeIcons.cloudRain, humidity!, '%'),
          Util.getItem(FontAwesomeIcons.wind, wind!.toInt(), 'm/s'),
      ],
    );
  }
}
