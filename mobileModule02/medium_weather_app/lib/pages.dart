import 'error_message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class StylePage extends StatelessWidget {
  const StylePage({super.key});

  static final Map<String, TextStyle> textStyles = {
    'default': TextStyle(color: Colors.white),
    'title': TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    'subtitle': TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  };
}

class CurrentlyPage extends StatelessWidget {
  const CurrentlyPage({
    super.key,
    required this.coord,
    required this.current,
    required this.errorText,
  });

  final Map<String, String> coord;
  final Map<String, String> current;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return errorText.isEmpty
        ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "${coord['cityName']}",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "${coord['region']}",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "${coord['country']}",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "${current['temp']}",
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            Text(
              "${current['weather']}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              "${current['wind']}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        )
        : ErrorMessage(errorMessage: errorText);
  }
}

class TodayPage extends StatelessWidget {
  const TodayPage({
    super.key,
    required this.coord,
    required this.today,
    required this.errorText,
  });

  final Map<String, String> coord;
  final Map<String, Map<String, String>> today;
  final String errorText;

  List<Widget> todayList() {
    List<Widget> list = [];

    String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

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

    list.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        child: Text(
          "Data: $todayDate",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    list.addAll(
      today.entries.map(
        (entry) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 3.0),
          child: Text(
            '${entry.value['hour']}   ${entry.value['temp']}    ${entry.value['wind']}    ${entry.value['weather']}',
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
        ? ListView(children: todayList())
        : ErrorMessage(errorMessage: errorText);
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
            style: TextStyle(color: Colors.white, fontSize: 15),
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
