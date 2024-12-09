import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/screens/weather_forecast_screen.dart';

import '../model/weather_forecast_daily.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {



  void getLocationData() async{
    try{
      WeatherForecast weatherInfo = await WeatherApi().fetchWeatherForecast();

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WeatherForecastScreen(locationWeather: weatherInfo,);
      } ));
    } catch(e){

        log(e.toString());


    }

  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitFadingCircle(
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
