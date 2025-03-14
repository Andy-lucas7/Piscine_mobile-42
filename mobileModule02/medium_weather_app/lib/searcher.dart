import 'error_message.dart';
import 'package:flutter/material.dart';

class CityInfoPage extends StatelessWidget {
  const CityInfoPage({
    super.key,
    required this.listOfCities,
    required this.changeText,
    required this.changeLatAndLong,
    required this.changeLocation,
    required this.errorText,
  });

  final dynamic listOfCities;
  final Function(String newText) changeText;
  final Function(double lat, double long) changeLatAndLong;
  final Function(String name, String region, String country) changeLocation;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return listOfCities != null
        ? ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          itemCount: listOfCities?.length ?? 10,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                if (listOfCities[index]["latitude"] != null &&
                    listOfCities[index]["longitude"] != null) {
                  changeLatAndLong(
                    listOfCities[index]["latitude"],
                    listOfCities[index]["longitude"],
                  );
                  changeText("");
                }
                if (listOfCities[index]['name'] != null &&
                    listOfCities[index]['admin1'] != null &&
                    listOfCities[index]['country'] != null) {
                  changeLocation(
                    listOfCities[index]['name'],
                    listOfCities[index]['admin1'],
                    listOfCities[index]['country'],
                  );
                }
              },
              title: Text(
                '${listOfCities?[index]['name']}, ${listOfCities?[index]['admin1']}, ${listOfCities?[index]['country']} ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'arial',
                ),
              ),
            );
          },
          separatorBuilder:
              (BuildContext context, int index) => const Divider(),
        )
        : errorText.isEmpty
        ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Text(
                  'no city found',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ],
          ),
        )
        : ErrorMessage(errorMessage: errorText);
  }
}
