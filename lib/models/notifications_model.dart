import 'dart:convert';

import 'package:http/http.dart' as http;

import '../views/constants/index.dart';

class NotifcationModel {
  final int? id;
  final String? createdAt;
  final String? url;
  final String? content;
  final String? title;
  NotifcationModel({
    this.id,
    this.createdAt,
    this.url,
    this.content,
    this.title,
  });

  factory NotifcationModel.fromJson(Map<dynamic, dynamic> json) {
    return NotifcationModel(id: json['id'], createdAt: json['created_date'], title: json['title'], content: json['description'], url: json['url']);
  }

  Future<List<NotifcationModel>> getNotifcations() async {
    final List<NotifcationModel> bannerList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/notifications/',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      for (final Map product in responseJson) {
        bannerList.add(NotifcationModel.fromJson(product));
      }

      return bannerList;
    } else {
      return [];
    }
  }
}
