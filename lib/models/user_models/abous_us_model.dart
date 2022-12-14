// ignore_for_file: file_names, always_use_package_imports, avoid_dynamic_calls, non_constant_identifier_names
import 'dart:convert';
import 'dart:io';

import 'package:game_app/views/constants/index.dart';
import 'package:http/http.dart' as http;

class AboutUsModel {
  final String? phone;
  final int? id;
  final String? email;
  final String? address_tm;
  final String? address_ru;
  AboutUsModel({
    this.phone,
    this.email,
    this.id,
    this.address_ru,
    this.address_tm,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(phone: json['phone'] as String, email: json['email'] as String, address_tm: json['address_tm'] as String, address_ru: json['address_ru'] as String, id: json['id'] as int);
  }

  Future<AboutUsModel> getAboutUs() async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/about/',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);

      return AboutUsModel.fromJson(responseJson);
    } else {
      return AboutUsModel();
    }
  }
}

class FAQModel {
  final int? id;
  final String? title_tm;
  final String? title_ru;
  final String? content_tm;
  final String? content_ru;
  FAQModel({
    this.id,
    this.title_tm,
    this.title_ru,
    this.content_tm,
    this.content_ru,
  });

  factory FAQModel.fromJson(Map<dynamic, dynamic> json) {
    return FAQModel(title_tm: json['title_tm'] as String, title_ru: json['title_ru'] as String, content_tm: json['content_tm'] as String, content_ru: json['content_ru'] as String, id: json['id'] as int);
  }

  Future<List<FAQModel>> getFAQ() async {
    final List<FAQModel> list = [];

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/about/questions/',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson) {
        list.add(FAQModel.fromJson(product));
      }
      return list;
    } else {
      return [];
    }
  }
}
