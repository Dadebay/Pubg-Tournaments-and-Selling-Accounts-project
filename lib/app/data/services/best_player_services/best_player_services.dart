import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../constants/packages/index.dart';
import '../../models/best_players_model/best_player_model.dart';

class BestPlayersServices {
  Future<List<BestPlayersModel>> getBestPlayers() async {
    final List<BestPlayersModel> bannerList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/accounts/best-players/',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      for (final Map product in responseJson) {
        bannerList.add(BestPlayersModel.fromJson(product));
      }
      return bannerList;
    } else {
      return [];
    }
  }
}
