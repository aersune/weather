import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/screens/location_screen.dart';

import 'model/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => WeatherProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LocationScreen(),
    );
  }
}
