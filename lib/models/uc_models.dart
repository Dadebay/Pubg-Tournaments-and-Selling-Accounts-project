// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:io';

import 'package:game_app/models/user_models/auth_model.dart';
import 'package:http/http.dart' as http;

import 'package:game_app/constants/index.dart';

class UcModel extends GetxController {
  UcModel({
    this.id,
    this.title,
    this.description_tm,
    this.description_ru,
    this.image,
    this.created_date,
    this.price,
  });

  factory UcModel.fromJson(Map<dynamic, dynamic> json) {
    return UcModel(
      id: json["id"],
      price: json["price"],
      title: json["title"],
      image: json["image"],
      description_tm: json["description_tm"],
      description_ru: json["description_ru"],
      created_date: json["created_date"],
    );
  }

  final int? id;
  final String? price;
  final String? title;
  final String? description_tm;
  final String? description_ru;
  final String? image;
  final String? created_date;

  Future addCart(List list, bool ask) async {
    final String? token = await Auth().getToken();
    final response = await http.post(Uri.parse("$serverURL/api/carts/add-cart/"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{"list": list, "ask": ask}));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return response.statusCode;
    }
  }

  Future<List<UcModel>> getUCS() async {
    final List<UcModel> ucList = [];
    final response = await http.get(
        Uri.parse(
          "$serverURL/api/ucs/",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      var decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson["results"]) {
        ucList.add(UcModel.fromJson(product));
      }
      return ucList;
    } else {
      return [];
    }
  }
}
