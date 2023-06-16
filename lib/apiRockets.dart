// Author: Reinan Br <slimchatuba@gmail.com>
// Project: App Schedule Launch' Rocket's 
// DateInit: 02/04/23
// DateUpdate: 23/05/23

import 'package:http/http.dart' as http;
import 'dart:convert';


String brockLine(String text, int limit) {
  var new_text_list = text.split(' ');
  if (text.split(' ').length / limit > 1) {
    var i = 0;
    for (var _ in text.split(' ').sublist(limit)) {
      if (i % limit == 0) {
        new_text_list.insert(i+limit, '\n');
      }
      i = i + 1;
    }
  }
  var new_word = new_text_list.join(' ').replaceAll('\n ', '\n');
  return new_word;
}




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
      name: brockLine(json['name'],4),
      mission: brockLine(json['mission'],6),
      empire: brockLine(json['empire'],3),
      date: json['date'],
      hour: json['hour'].replaceAll('2023',''),
      location: json['location'],
      img_url: json['img_url'],
    );
  }
}
