import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:imbi/widgets/info_card.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  double? _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: _dataCard(),
    );
  }

  Widget _dataCard() {
    return FutureBuilder(
      // future: Future.delayed(const Duration(seconds: 2), () => 2),
      future: SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(allowList: null),
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final prefs = snapshot.data as SharedPreferencesWithCache;
          final date = prefs.getString("bmi_date");
          final data = prefs.getStringList("bmi_data");
          return Center(
            child: InfoCard(
              height: _deviceHeight! * 0.25,
              width: _deviceWidth! * 0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _statusText(data![1]),
                  _dateText(date!),
                  _bmiText(data[0]),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CupertinoActivityIndicator(
              color: CupertinoColors.activeBlue,
            ),
          );
        }
      }
    );
  }

  Widget _statusText(String status) {
    return Text(
      status,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _dateText(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return Text(
      "${parsedDate.day} / ${parsedDate.month} / ${parsedDate.year}",
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _bmiText(String bmi) {
    return Text(
      double.parse(bmi).toStringAsFixed(2),
      style: const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
