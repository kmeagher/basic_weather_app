
import 'package:flutter/material.dart';
import '../config/constant.dart';
import '../model/weather_period.dart';

class WeatherPeriodComponent extends StatefulWidget {
  final WeatherPeriod weatherPeriod;
  const WeatherPeriodComponent({super.key, required this.weatherPeriod});
  @override
  State<StatefulWidget> createState() => _WeatherPerdioComponentState();
}

class _WeatherPerdioComponentState extends State<WeatherPeriodComponent> {

  final TextStyle _tempSytle = const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 28);
  final TextStyle _headerStyle = const TextStyle(fontWeight: FontWeight.w900, fontSize: 32);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Text(widget.weatherPeriod.name, style: _headerStyle),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text("${widget.weatherPeriod.temperatureFahrenheit()} F${Symbol.degress}", style: _tempSytle, textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Text("${widget.weatherPeriod.temperatureCelcius()} C${Symbol.degress}", style: _tempSytle, textAlign: TextAlign.center,),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(widget.weatherPeriod.detailFormatted()),
        const SizedBox(height:20),
        Text("Chance of Rain: ${widget.weatherPeriod.probabilityOfPrecipitation.value ?? 0}%"),
        const SizedBox(height: 20),
        Text("Wind: ${widget.weatherPeriod.windSpeed} ${widget.weatherPeriod.windDirection}"),
      ],),
    );
  }
  
}