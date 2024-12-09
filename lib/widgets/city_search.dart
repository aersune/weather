import 'package:flutter/material.dart';


class CitySearch extends StatefulWidget {
  final Future<void> Function() onPressed;
  const CitySearch({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<CitySearch> createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  late String cityName;
  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: TextFormField(
          textInputAction: TextInputAction.done,
          autofocus: false,
          cursorColor: Colors.blueGrey[800],
          style: const TextStyle(color: Colors.white, fontSize: 20),
          decoration: const InputDecoration(
            hintText: 'Enter City Name',
            hintStyle: TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.deepOrangeAccent,
            border: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none
            ),
            icon:Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
          onChanged: (value) {
            cityName = value;
          },
          onFieldSubmitted: (v){
            FocusScope.of(context).requestFocus(focus);
            // widget.cityChange(v);
            // Navigator.pop(context, cityName);
          },
        ),
      ),
    );
  }
}
