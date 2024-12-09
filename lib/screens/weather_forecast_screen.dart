import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/model/provider.dart';
import 'package:weather/widgets/bottom_list_view.dart';
import 'package:weather/widgets/city_view.dart';
import 'package:weather/widgets/detail_view.dart';
import 'package:weather/widgets/temp_view.dart';
import '../model/weather_forecast_daily.dart';
import 'package:http/http.dart' as http;

class WeatherForecastScreen extends StatefulWidget {
  final WeatherForecast locationWeather;

  const WeatherForecastScreen({super.key, required this.locationWeather});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  String _cityName = 'London';

  // String bgImage = 'assets/day.png';
  DateTime? sunRise;
  DateTime? sunSet;
  ValueNotifier<String> bgImage = ValueNotifier('assets/day.png');

  @override
  void initState() {
    super.initState();
    forecastObject = Future.value(widget.locationWeather);
    sunRise = DateTime.fromMillisecondsSinceEpoch(widget.locationWeather.list![0].sunrise! * 1000);
    sunSet = DateTime.fromMillisecondsSinceEpoch(widget.locationWeather.list![0].sunset! * 1000);
    _updateBackgroundImage(sunRise, sunSet);
  }

  late String city;
  final focus = FocusNode();
  Color whiteColor = Colors.white;

  TextEditingController inputText = TextEditingController();
  FocusNode focusNode = FocusNode();




  void _updateBackgroundImage(sunrise, sunset) {

    Future.delayed(const Duration(milliseconds: 500), () {
      final DateTime now = DateTime.now();
      if (sunset != null && sunrise != null) {
        String getBackgroundImage() {
          if (now.isAfter(sunrise!) && now.isBefore(sunset!)) {
            return 'assets/day.png';
          } else if (now.isAfter(sunrise!.subtract(const Duration(hours: 1))) &&
              now.isBefore(sunrise!.add(const Duration(hours: 1)))) {
            return 'assets/sunset.png';
          } else if (now.isAfter(sunset!.subtract(const Duration(hours: 1))) &&
              now.isBefore(sunset!.add(const Duration(hours: 1)))) {
            return 'assets/sunset.png';
          } else {
            return 'assets/night.png';
          }
        }


        bgImage.value = getBackgroundImage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: ValueListenableBuilder(
            valueListenable: bgImage,
            builder: (context, value, child) {
              return Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        value,
                      ),
                      fit: BoxFit.cover),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Spacer(),
                              const Text('Weather Forecast',
                                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500)),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: IconButton(
                                  icon: const Icon(Icons.my_location, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      forecastObject = WeatherApi().fetchWeatherForecast();
                                    });
                                    // WeatherForecast weatherInfo = await  WeatherApi().fetchWeatherForecast() ;
                                    // _updateBackgroundImage(weatherInfo.list![0].sunrise, weatherInfo.list![0].sunset);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            FutureBuilder<WeatherForecast>(
                              future: forecastObject,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {


                                  return Column(
                                    children: [
                                      formField(),
                                      const SizedBox(height: 20),
                                      CityView(snapshot: snapshot),
                                      const SizedBox(height: 30),
                                      TempView(snapshot: snapshot),
                                      const SizedBox(height: 30),
                                      DetailView(snapshot: snapshot),
                                      const SizedBox(height: 40),
                                      BottomLisView(
                                        snapshot: snapshot,
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container(
                                    height: MediaQuery.of(context).size.height,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        formField(),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          '! City not found \n Please, enter correct city !',
                                          style: TextStyle(fontSize: 25, color: Colors.red),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget formField() {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextFormField(
        controller: inputText,
        focusNode: focusNode,
        textInputAction: TextInputAction.done,
        autofocus: false,
        cursorColor: Colors.blueGrey[800],
        style: const TextStyle(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
          hintText: 'Enter City Name',
          hintStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, fontSize: 14),
          filled: true,
          fillColor: Colors.transparent,
          border: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
          icon: const Icon(
            Icons.search,
            color: Colors.black12,
            size: 30,
          ),
          suffixIcon: IconButton(
              onPressed: ()  {
                setState(() {
                  _cityName = city;
                  forecastObject = WeatherApi().fetchWeatherForecast(cityName: _cityName, isCity: true);
                  inputText.clear();
                  focusNode.unfocus();

                });


              },
              icon: const Icon(
                Icons.navigate_next_outlined,
                size: 35,
                color: Colors.white,
              )),
        ),
        onChanged: (value) {
          city = value;
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(focus);
          setState(() {
            _cityName = value;
            forecastObject = WeatherApi().fetchWeatherForecast(cityName: _cityName, isCity: true);
          });
          // Navigator.pop(context, cityName);
        },
      ),
    );
  }
}
