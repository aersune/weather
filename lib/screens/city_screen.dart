import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            cursorColor: Colors.blueGrey[800],
            style: const TextStyle(color: Colors.white, fontSize: 20),
            decoration:  InputDecoration(
              hintText: 'Enter City Name',
              hintStyle: const TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.deepOrangeAccent,
              border: const OutlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none),
              suffixIcon: IconButton(onPressed: () {

              }, icon: const Icon(Icons.add)),

              icon: const Icon(
                Icons.search,
                color: Colors.deepOrangeAccent,
                size: 40,
              ), floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
            onChanged: (value) {
              cityName = value;
            },
          ),
        ),
        // TextButton(
        //     onPressed: (){
        //       Navigator.pop(context,cityName);
        //     },
        //     child: Text('Get weather', style: TextStyle(fontSize: 30),)
        // )
      ],
    );
  }
}
