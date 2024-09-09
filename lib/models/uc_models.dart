// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:io';

import 'package:game_app/models/user_models/auth_model.dart';
import 'package:http/http.dart' as http;

import '../views/constants/index.dart';

class UcModel {
  final int? id;
  final String? price;
  final String? liraPrice;
  final String? rublePrice;
  final String? title;
  final String? description_tm;
  final String? description_ru;
  final String? image;
  final String? created_date;
  UcModel({
    this.id,
    this.title,
    this.liraPrice,
    this.rublePrice,
    this.description_tm,
    this.description_ru,
    this.image,
    this.created_date,
    this.price,
  });

  factory UcModel.fromJson(Map<dynamic, dynamic> json) {
    return UcModel(
      id: json['id'] ?? 0,
      price: json['price'] ?? 'null',
      rublePrice: json['ruble_price'] ?? 'null',
      liraPrice: json['lira_price'] ?? 'null',
      title: json['title'] ?? 'null',
      image: json['image'] ?? 'null',
      description_tm: json['description_tm'] ?? 'null',
      description_ru: json['description_ru'] ?? 'null',
      created_date: json['created_date'] ?? 'null',
    );
  }

  Future addCart(List list, bool ask, String pubgID) async {
    final String? token = await Auth().getToken();
    final response = await http.post(
      Uri.parse('$serverURL/api/carts/add-cart/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{'list': list, 'ask': ask, 'pubg_id': pubgID == '' ? null : pubgID}),
    );

    return response.statusCode;
  }

  Future<List<UcModel>> getUCS() async {
    final List<UcModel> ucList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/ucs/',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson['results']) {
        ucList.add(UcModel.fromJson(product));
      }
      return ucList;
    } else {
      return [];
    }
  }
}
