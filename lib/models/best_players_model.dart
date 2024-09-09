import 'dart:convert';

import 'package:http/http.dart' as http;

import '../views/constants/index.dart';

class BestPlayersModel {
  final int? id;
  final String? pubgUsername;
  final String? image;
  final String? points;
  BestPlayersModel({
    this.id,
    this.pubgUsername,
    this.image,
    this.points,
  });

  factory BestPlayersModel.fromJson(Map<dynamic, dynamic> json) {
    return BestPlayersModel(id: json['id'], pubgUsername: json['pubg_username'], points: json['points_from_turnir'], image: json['image']);
  }

  Future<List<BestPlayersModel>> getBestPlayers() async {
    final List<BestPlayersModel> bannerList = [];
    final response = await http.get(
      Uri.parse('$serverURL/api/accounts/best-players/'),
      headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8', 'Charset': 'utf-8'},
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      for (final Map product in responseJson['results']) {
        bannerList.add(BestPlayersModel.fromJson(product));
      }

      return bannerList;
    } else {
      return [];
    }
  }
}
