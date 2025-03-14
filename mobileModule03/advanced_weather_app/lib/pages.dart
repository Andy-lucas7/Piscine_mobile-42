import 'error_message.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'chart_for_today.dart';
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
  final yourScrollController = ScrollController();

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
        mainAxisSize: MainAxisSize.max,
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
              radius: const Radius.circular(20),
              thickness: 5,
              controller: yourScrollController,
              child: ListView(
                controller: yourScrollController,
                scrollDirection: Axis.horizontal,
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
  const WeeklyPage({
    super.key,
    required this.coord,
    required this.weekly,
    required this.errorText,
  });

  final Map<String, String> coord;
  final Map<String, Map<String, String>> weekly;
  final String errorText;

  List<Widget> weeklyList() {
    List<Widget> list = [];

    list.add(
      Center(
        child: Text(
          "${coord['cityName']}",
          style: StylePage.textStyles['title'],
        ),
      ),
    );
    list.add(
      Center(
        child: Text("${coord['region']}", style: StylePage.textStyles['title']),
      ),
    );
    list.add(
      Center(
        child: Text(
          "${coord['country']}",
          style: StylePage.textStyles['title'],
        ),
      ),
    );
    list.addAll(
      weekly.entries.map(
        (entry) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
          child: Text(
            '${entry.value['date']}      |      ${entry.value['min']}    ${entry.value['max']}      |      ${entry.value['weather']}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: StylePage.textStyles['default'],
          ),
        ),
      ),
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return errorText.isEmpty
        ? ListView(children: weeklyList())
        : ErrorMessage(errorMessage: errorText);
  }
}
