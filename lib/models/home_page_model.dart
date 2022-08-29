// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:game_app/constants/index.dart';

class BannerModel extends GetxController {
  BannerModel({
    this.id,
    this.image,
    this.url,
  });

  factory BannerModel.fromJson(Map<dynamic, dynamic> json) {
    return BannerModel(id: json["id"], image: json["image"], url: json['url']);
  }

  final int? id;
  final String? image;
  final String? url;

  Future<List<BannerModel>> getBanners() async {
    final List<BannerModel> bannerList = [];
    final response = await http.get(
        Uri.parse(
          "$serverURL/api/banners/",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      var decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson) {
        bannerList.add(BannerModel.fromJson(product));
      }

      return bannerList;
    } else {
      return [];
    }
  }
}

class PubgTypesModel extends GetxController {
  PubgTypesModel({
    this.id,
    this.image,
    this.title,
  });

  factory PubgTypesModel.fromJson(Map<dynamic, dynamic> json) {
    return PubgTypesModel(id: json["id"], image: json["image"], title: json['title']);
  }

  final int? id;
  final String? image;
  final String? title;

  Future<List<PubgTypesModel>> getTypes() async {
    final List<PubgTypesModel> typeList = [];
    final response = await http.get(
        Uri.parse(
          "$serverURL/api/accounts/types/",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      var decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson) {
        typeList.add(PubgTypesModel.fromJson(product));
      }

      return typeList;
    } else {
      return [];
    }
  }
}

class Cities extends GetxController {
  Cities({
    this.id,
    this.name_tm,
    this.name_ru,
  });

  factory Cities.fromJson(Map<dynamic, dynamic> json) {
    return Cities(id: json["id"], name_tm: json["name_tm"], name_ru: json['name_ru']);
  }

  final int? id;
  final String? name_tm;
  final String? name_ru;

  Future<List<Cities>> getCities() async {
    final List<Cities> typeList = [];
    final response = await http.get(
        Uri.parse(
          "$serverURL/api/accounts/locations/",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      var decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson) {
        typeList.add(Cities.fromJson(product));
      }

      return typeList;
    } else {
      return [];
    }
  }
}
