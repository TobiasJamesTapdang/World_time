import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String flag;
  String? time;
  String urls;
  bool isDayTime = true;

  WorldTime({required this.flag, required this.location, required this.urls});

  Future<void> getTime() async {
    final Uri url = Uri.parse('http://worldtimeapi.org/api/timezone/$urls');
    final response = await http.get(url);
    Map data = jsonDecode(response.body);

    String dateTime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);

    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(offset)));
    isDayTime = now.hour > 6 && now.hour < 18 ? isDayTime : !isDayTime;
    time = DateFormat.jm().format(now);
  }
}
