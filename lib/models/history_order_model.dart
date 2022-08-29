// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:io';

import 'package:game_app/models/user_models/auth_model.dart';
import 'package:http/http.dart' as http;

import 'package:game_app/constants/index.dart';

class HistoryOrderModel extends GetxController {
  HistoryOrderModel({this.id, this.status, this.created_date});

  factory HistoryOrderModel.fromJson(Map<dynamic, dynamic> json) {
    return HistoryOrderModel(id: json["id"], status: json["status"], created_date: json["created_date"]);
  }

  final int? id;
  final String? status;
  final String? created_date;

  Future<List<HistoryOrderModel>> getOrders() async {
    final token = await Auth().getToken();
    final List<HistoryOrderModel> tournamentList = [];
    final response = await http.get(
        Uri.parse(
          "$serverURL/api/carts/",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);

      for (final Map product in responseJson) {
        tournamentList.add(HistoryOrderModel.fromJson(product));
      }

      return tournamentList;
    } else {
      return [];
    }
  }

  Future<HistoryOrderModel> getOrderByID(int id) async {
    final token = await Auth().getToken();

    final response = await http.get(
        Uri.parse(
          "$serverURL/api/carts/get-cart/$id/",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);

      return HistoryOrderModel.fromJson(responseJson);
    } else {
      return HistoryOrderModel();
    }
  }
}
