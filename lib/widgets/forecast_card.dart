import 'package:flutter/material.dart';
import 'package:weather/utilities/forecast_util.dart';

Widget forecastCard(AsyncSnapshot snapshot, int index,context) {
  var forecastList = snapshot.data?.list;
  var dayOfWeak = '';
  DateTime date =
      DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt * 1000);
  var fullDate = Util.getFotmatattedDate(date);
  dayOfWeak = fullDate.split(',')[0];
  var tempMin = forecastList[index].temp.min.toStringAsFixed(0);
  var icon = forecastList[index].getIconUrl();
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            dayOfWeak,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '$tempMin °C',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width /15 ,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Image.network(icon, scale: 1.9, color: Colors.white,)
                ],
              )
            ],
          )
        ],
      )
    ],
  );
}
