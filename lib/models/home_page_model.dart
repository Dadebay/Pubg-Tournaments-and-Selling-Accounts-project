// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../views/constants/index.dart';

class BannerModel {
  final int? id;
  final String? image;
  final String? url;
  final String? content;
  final String? title;
  BannerModel({
    this.id,
    this.image,
    this.url,
    this.content,
    this.title,
  });

  factory BannerModel.fromJson(Map<dynamic, dynamic> json) {
    return BannerModel(id: json['id'], image: json['image'] ?? '', title: json['title'] ?? '', content: json['content'] ?? '', url: json['url'] ?? '');
  }

  Future<List<BannerModel>> getBanners() async {
    final List<BannerModel> bannerList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/banners/',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      for (final Map product in responseJson) {
        bannerList.add(BannerModel.fromJson(product));
      }
      return bannerList;
    } else {
      return [];
    }
  }
}

class Cities extends GetxController {
  final int? id;
  final String? name_tm;
  final String? name_ru;
  Cities({
    this.id,
    this.name_tm,
    this.name_ru,
  });

  factory Cities.fromJson(Map<dynamic, dynamic> json) {
    return Cities(id: json['id'], name_tm: json['name_tm'], name_ru: json['name_ru']);
  }

  Future<List<Cities>> getCities() async {
    final List<Cities> typeList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/accounts/locations/',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
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
