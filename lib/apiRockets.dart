import 'package:http/http.dart' as http;
import 'dart:convert';



Future<List<LaunchRocket>> fetchLaunch() async {
  final http.Response response =
      await http.get(Uri.parse('https://api-rocketlc.vercel.app/ssl'));
  if (response.statusCode == 200) {
    final responseJson = json.decode(utf8.decode(response.bodyBytes));
    print('eu toh indo');
    return (responseJson['body'] as List)
        .map((launch) => LaunchRocket.fromJson(launch))
        .toList();
  } else {
    print('eu N toh indo');
    throw Exception('error url');
  }
}

class LaunchRocket {
  final String name, mission, empire, date, hour, location, img_url;

  LaunchRocket(
      {required this.name,
      required this.mission,
      required this.empire,
      required this.date,
      required this.hour,
      required this.location,
      required this.img_url});

  factory LaunchRocket.fromJson(Map<String, dynamic> json) {
    print('todo cao voa');
    return new LaunchRocket(
      name: json['name'],
      mission: json['mission'],
      empire: json['empire'],
      date: json['date'],
      hour: json['hour'],
      location: json['location'],
      img_url: json['img_url'],
    );
  }
}
