import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

String getFirstDayOfTheWeekInString() {
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);
  DateTime realDate = date.subtract(Duration(days: date.weekday - 1));
  var dateTime = realDate.toString();
  dateTime = dateTime.substring(0, dateTime.indexOf(" "));
  return dateTime;
}

final Map<String, String> weatherMap = {
  '0': 'Clear sky',
  '1': 'Mainly clear',
  '2': 'Partly cloudy',
  '3': 'Overcast',
  '45': 'Fog and depositing rime fog',
  '48': 'Fog and depositing rime fog',
  '51': 'Drizzle: Light intensity',
  '53': 'Drizzle: Moderate intensity',
  '55': 'Drizzle: Dense intensity',
  '56': 'Freezing Drizzle: Light intensity',
  '57': 'Freezing Drizzle: Dense intensity',
  '61': 'Rain: Slight intensity',
  '63': 'Rain: Moderate intensity',
  '65': 'Rain: Heavy intensity',
  '66': 'Freezing Rain: Light intensity',
  '67': 'Freezing Rain: Heavy intensity',
  '71': 'Snow fall: Slight intensity',
  '73': 'Snow fall: Moderate intensity',
  '75': 'Snow fall: Heavy intensity',
  '77': 'Snow grains',
  '80': 'Rain showers: Slight intensity',
  '81': 'Rain showers: Moderate intensity',
  '82': 'Rain showers: Violent intensity',
  '85': 'Snow showers: Slight intensity',
  '86': 'Snow showers: Heavy intensity',
  '95': 'Thunderstorm: Slight or moderate',
  '96': 'Thunderstorm with slight hail',
  '99': 'Thunderstorm with heavy hail',
};

final Map<String, IconData> weatherIcons = {
  'Clear sky': CupertinoIcons.sun_max,
  'Mainly clear': Icons.wb_sunny,
  'Partly cloudy': Icons.wb_cloudy,
  'Overcast': Icons.cloud,
  'Fog and depositing rime fog': Icons.cloud,
  'Drizzle: Light intensity': Icons.grain,
  'Drizzle: Moderate intensity': Icons.grain,
  'Drizzle: Dense intensity': Icons.grain,
  'Freezing Drizzle: Light intensity': Icons.ac_unit,
  'Freezing Drizzle: Dense intensity': Icons.ac_unit,
  'Rain: Slight intensity': CupertinoIcons.cloud_rain,
  'Rain: Moderate intensity': Icons.grain,
  'Rain: Heavy intensity': Icons.grain,
  'Freezing Rain: Light intensity': Icons.ac_unit,
  'Freezing Rain: Heavy intensity': Icons.ac_unit,
  'Snow fall: Slight intensity': Icons.ac_unit,
  'Snow fall: Moderate intensity': Icons.ac_unit,
  'Snow fall: Heavy intensity': Icons.ac_unit,
  'Snow grains': Icons.grain,
  'Rain showers: Slight intensity': CupertinoIcons.cloud_heavyrain,
  'Rain showers: Moderate intensity': Icons.grain,
  'Rain showers: Violent intensity': Icons.grain,
  'Snow showers: Slight intensity': Icons.ac_unit,
  'Snow showers: Heavy intensity': Icons.ac_unit,
  'Thunderstorm: Slight or moderate': CupertinoIcons.cloud_bolt_rain_fill,
  'Thunderstorm with slight hail': CupertinoIcons.cloud_bolt_rain_fill,
  'Thunderstorm with heavy hail': CupertinoIcons.cloud_bolt_rain_fill,
};

Color getIconColor(String weather) {
  switch (weather) {
    case 'Clear sky':
    case 'Mainly clear':
      return const Color.fromARGB(255, 255, 217, 1);
    case 'Partly cloudy':
    case 'Overcast':
      return Colors.white;
    case 'Drizzle: Light intensity':
    case 'Drizzle: Moderate intensity':
    case 'Drizzle: Dense intensity':
    case 'Rain: Slight intensity':
    case 'Rain: Moderate intensity':
    case 'Rain: Heavy intensity':
    case 'Rain showers: Slight intensity':
    case 'Rain showers: Moderate intensity':
    case 'Rain showers: Violent intensity':
      return const Color.fromARGB(255, 178, 201, 219);
    case 'Freezing Drizzle: Light intensity':
    case 'Freezing Drizzle: Dense intensity':
    case 'Freezing Rain: Light intensity':
    case 'Freezing Rain: Heavy intensity':
      return const Color.fromARGB(255, 185, 233, 240);
    case 'Snow fall: Slight intensity':
    case 'Snow fall: Moderate intensity':
    case 'Snow fall: Heavy intensity':
    case 'Snow grains':
    case 'Snow showers: Slight intensity':
    case 'Snow showers: Heavy intensity':
      return const Color.fromARGB(255, 255, 255, 255);
    case 'Thunderstorm: Slight or moderate':
    case 'Thunderstorm with slight hail':
    case 'Thunderstorm with heavy hail':
      return const Color.fromARGB(255, 125, 141, 163);
    default:
      return Colors.white;
  }
}

final Map<String, String> location = {
  'cityName': '',
  'region': '',
  'country': '',
  'lat': '',
  'long': '',
};
