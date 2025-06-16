// Author: Reinan Br <slimchatuba@gmail.com>
// Project: App Schedule Launch' Rocket's 
// DateInit: 02/04/23
// DateUpdate: 16/06/25

import 'package:http/http.dart' as http;
import 'dart:convert';

String brockLine(String text, int limit) {
  final words = text.split(' ');
  if (words.length <= limit) return text;

  final buffer = StringBuffer();
  for (int i = 0; i < words.length; i++) {
    buffer.write(words[i]);
    if ((i + 1) % limit == 0 && i != words.length - 1) {
      buffer.write('\n');
    } else if (i != words.length - 1) {
      buffer.write(' ');
    }
  }
  return buffer.toString();
}

Future<List<LaunchRocket>> fetchLaunch() async {
  try {
    final response = await http.get(Uri.parse('https://api-rocketlc.vercel.app/api/ssl'));

    if (response.statusCode == 200) {
      final List launches = json.decode(utf8.decode(response.bodyBytes));
      return launches.asMap().entries.map((entry) {
        int index = entry.key + 1;
        return LaunchRocket.fromJson(entry.value, index);
      }).toList();
    } else {
      throw Exception('Failed to load launches: HTTP ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Erro ao buscar lançamentos: $e');
  }
}

class LaunchRocket {
  final String name;
  final String mission;
  final String empire;
  final String date;
  final String hour;
  final String location;
  final String imgUrl;
  final int count;
  final String datetime;
  final double resSeconds;

  LaunchRocket({
    required this.name,
    required this.mission,
    required this.empire,
    required this.date,
    required this.hour,
    required this.location,
    required this.imgUrl,
    required this.count,
    required this.datetime,
    required this.resSeconds,
  });

  factory LaunchRocket.fromJson(Map<String, dynamic> json, int count) {
    return LaunchRocket(
      name: brockLine(json['name'] ?? '', 4),
      mission: brockLine(json['mission'] ?? '', 6),
      empire: brockLine(json['empire'] ?? '', 3),
      date: json['date'] ?? '',
      hour: json['hour'] ?? '',
      location: json['location'] ?? '',
      imgUrl: json['img_url'] ?? '',
      count: count,
      datetime: json['datetime'] ?? '',
      resSeconds: (json['res_seconds'] is int)
          ? (json['res_seconds'] as int).toDouble()
          : (json['res_seconds'] is double)
              ? json['res_seconds']
              : double.tryParse(json['res_seconds']?.toString() ?? '0') ?? 0,
    );
  }

  factory LaunchRocket.fromMap(Map<String, dynamic> map) {
    return LaunchRocket(
      name: map['name'],
      mission: map['mission'],
      empire: map['empire'],
      date: map['date'],
      hour: map['hour'],
      location: map['location'],
      imgUrl: map['img_url'],
      count: map['count'],
      datetime: map['datetime'],
      resSeconds: (map['res_seconds'] is int)
          ? (map['res_seconds'] as int).toDouble()
          : (map['res_seconds'] is double)
              ? map['res_seconds']
              : double.tryParse(map['res_seconds']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mission': mission,
      'empire': empire,
      'date': date,
      'hour': hour,
      'location': location,
      'img_url': imgUrl,
      'count': count,
      'datetime': datetime,
      'res_seconds': resSeconds,
    };
  }

  String toJsonString() => json.encode(toMap());

  static LaunchRocket fromJsonString(String jsonString) =>
      LaunchRocket.fromMap(json.decode(jsonString));

  static List<LaunchRocket> fromList(List<dynamic> list) =>
      list.map((item) => LaunchRocket.fromMap(item)).toList();

  @override
  String toString() =>
      'LaunchRocket{name: $name, mission: $mission, empire: $empire, date: $date, hour: $hour, location: $location, imgUrl: $imgUrl, count: $count, datetime: $datetime, resSeconds: $resSeconds}';
}
