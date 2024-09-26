import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  DetailsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _conversionView(),
    );
  }

  Widget _conversionView() {
    Map<String, dynamic> conversionDataMap =
        data["market_data"]["current_price"];
    print(conversionDataMap);

    List<MapEntry<String, dynamic>> conversionDataList =
        conversionDataMap.entries.toList(); 

    return ListView.builder(
      itemCount: conversionDataMap.length,
      itemBuilder: (BuildContext context, int index) {
        MapEntry<String, dynamic> entry = conversionDataList[index];
        return ListTile(
          title: Text(
            "${entry.key.toUpperCase()}: ${entry.value.toString()}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
