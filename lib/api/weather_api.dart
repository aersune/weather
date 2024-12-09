import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import '../model/weather_forecast_daily.dart';
import '../utilities/constans.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import '../utilities/location.dart';

class WeatherApi{
    Future<WeatherForecast> fetchWeatherForecast(
        {String? cityName, bool? isCity}) async{
        LocationPermission permission;
        permission = await Geolocator.requestPermission();
        Location location = Location();
        await location.getCurrentLocation();

        Map<String,String>? parametres;

        if(isCity == true){
            var queryParametres = {
                'appid' : Constants.WEATHER_APP_ID,
                'units' : 'metric',
                'q' : cityName,
            };
            parametres = queryParametres.cast<String, String>();
        }else{
            var queryParametres = {
                'appid' : Constants.WEATHER_APP_ID,
                'units' : 'metric',
                'lat' : location.latitude.toString(),
                'lon' : location.longitude.toString(),
            };
            parametres = queryParametres.cast<String, String>();
        }

        var uri = Uri.http(Constants.WEATHER_BASE_URL_DOMAIN, Constants.WEATHER_FORECAST_PATH, parametres);
        
        log('request: ${uri.toString()}');

        var response = await http.get(uri);
        
        print('response:${response.body}');

        if(response.statusCode == 200){
            return WeatherForecast.fromJson(json.decode(response.body));
        } else{
            return Future.error('Error response');
        }
    }
}