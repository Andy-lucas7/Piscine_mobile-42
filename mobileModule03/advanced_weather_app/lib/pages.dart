import 'error_message.dart';
import 'package:flutter/material.dart';
import 'chart_for_today.dart';
import 'chart_for_weekly.dart';
import 'utils.dart';
import 'package:flutter/cupertino.dart';

abstract class StylePage extends StatelessWidget {
  const StylePage({super.key});

  static final Map<String, TextStyle> textStyles = {
    'default': TextStyle(
      fontFamily: 'Manrope',
      color: Colors.white,
      fontSize: 18,
    ),
    'title': TextStyle(
      fontFamily: 'Manrope',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    'subtitle': TextStyle(
      fontFamily: 'Manrope',
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  };
}

class CurrentlyPage extends StatelessWidget {
  CurrentlyPage({
    super.key,
    required this.coord,
    required this.current,
    required this.errorText,
  });

  final Map<String, String> coord;
  final Map<String, String> current;
  final Map<String, IconData> wIcons = weatherIcons;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return errorText.isEmpty
        ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.04 * MediaQuery.of(context).size.height,
              ),
            ),
            Text(
              "${coord['cityName']}",
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 207, 239, 247),
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w200,
              ),
            ),
            Text(
              "${coord['region']}, ${coord['country']}",
              style: StylePage.textStyles['title'],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.03 * MediaQuery.of(context).size.height,
              ),
            ),
            Text(
              "${current['temp']}",
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w300,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.03 * MediaQuery.of(context).size.height,
              ),
            ),
            Icon(
              weatherIcons[current['weather']],
              color: getIconColor('${current['weather']}'),
              size: 90,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.02 * MediaQuery.of(context).size.height,
              ),
            ),
            Text(
              "${current['weather']}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  CupertinoIcons.wind,
                  color: const Color.fromARGB(255, 208, 224, 233),
                ),
                Text(
                  " ${current['wind']}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        )
        : ErrorMessage(errorMessage: errorText);
  }
}

class TodayPage extends StatelessWidget {
  TodayPage({super.key, required this.coord, required this.today});

  final Map<String, String> coord;
  final Map<String, Map<String, String>> today;
  final yourScrollController = ScrollController(keepScrollOffset: true);

  final Map<String, IconData> wIcons = weatherIcons;

  List<Widget> todayList() {
    List<Widget> list = [];

    list.addAll(
      today.entries.map(
        (entry) => Container(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${entry.value['hour']}",
                style: StylePage.textStyles['default'],
              ),
              const SizedBox(height: 15.0),
              Icon(
                weatherIcons[entry.value['weather']],
                color: getIconColor("${entry.value['weather']}"),
                size: 50,
              ),
              const SizedBox(height: 15.0),
              Text(
                "${entry.value['temp']}",
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 254),
                  fontSize: 15.00,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.wind,
                    color: Color.fromARGB(255, 172, 209, 230),
                  ),
                  Text(
                    " ${entry.value['wind']}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          Text(
            "${coord['cityName']}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w100,
            ),
          ),
          Text(
            "${coord['region']}, ${coord['country']}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            height: 20.0,
            margin: const EdgeInsets.all(30),
            child: const Center(
              child: Text(
                "Today temperatures",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ChartToday(map: today),
          SizedBox(
            height: 175,
            child: RawScrollbar(
              thumbVisibility: true,
              thumbColor: const Color.fromARGB(255, 132, 216, 255),
              minThumbLength: 100,
              radius: const Radius.circular(20),
              thickness: 13,
              controller: yourScrollController,
              child: ListView(
                scrollDirection: Axis.values[0],
                controller: yourScrollController,
                children: todayList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeeklyPage extends StatelessWidget {
  WeeklyPage({super.key, required this.coord, required this.weekly});

  final Map<String, String> coord;
  final Map<String, Map<String, String>> weekly;
  final yourScrollController = ScrollController();

  final Map<String, IconData> wIcons = weatherIcons;

  List<Widget> weeklyList() {
    List<Widget> list = [];

    list.addAll(
      weekly.entries.map(
        (entry) => Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${entry.value['date']}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Manrope',
                ),
              ),
              const SizedBox(height: 20.0),
              Icon(
                weatherIcons[entry.value['weather']],
                color: getIconColor("${entry.value['weather']}"),
                size: 50,
              ),
              const SizedBox(height: 10.0),
              Text(
                "${entry.value['max']}",
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15.00,
                ),
              ),
              Text(
                "${entry.value['min']}",
                style: const TextStyle(
                  color: Color.fromARGB(255, 217, 235, 247),
                  fontSize: 15.00,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          Text(
            "${coord['cityName']}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w100,
            ),
          ),
          Text(
            "${coord['region']}, ${coord['country']}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            height: 20.0,
            margin: const EdgeInsets.all(20),
            child: const Center(
              child: Text(
                "Weekly temperatures",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),

          ChartWeek(map: weekly),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 45),
              Icon(Icons.show_chart, color: Color.fromARGB(255, 138, 202, 255)),
              Text('min temperature', style: TextStyle(color: Colors.white)),
              SizedBox(width: 10),
              Icon(Icons.show_chart, color: Color.fromARGB(255, 0, 183, 255)),
              Text('max temperature', style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(
            height: 170,
            child: RawScrollbar(
              thumbVisibility: true,
              thumbColor: const Color.fromARGB(255, 132, 216, 255),
              minThumbLength: 100,
              radius: const Radius.circular(20),
              thickness: 13,
              controller: yourScrollController,
              child: ListView(
                scrollDirection: Axis.horizontal,
                controller: yourScrollController,
                children: weeklyList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
