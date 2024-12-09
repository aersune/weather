import 'package:flutter/material.dart';
import '../model/weather_forecast_daily.dart';
import 'forecast_card.dart';

class BottomLisView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const BottomLisView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    return Column(
      children: [
        Text('7-Day Weather Forecast'.toUpperCase(), style: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400
        ),),
        Container(
          height: 140,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: snapshot.data!.list!.length,
            itemBuilder: (context, index) => Container(
              width: MediaQuery.of(context).size.width / 2.7,
              height: 160,
              color: Colors.white.withOpacity(0.2),
              child: forecastCard(snapshot, index, context),
            ),
          ),
        )
      ],
    );
  }
}
