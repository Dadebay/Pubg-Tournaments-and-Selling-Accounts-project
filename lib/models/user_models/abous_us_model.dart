// ignore_for_file: file_names, always_use_package_imports, avoid_dynamic_calls, non_constant_identifier_names
import 'dart:convert';
import 'dart:io';

import 'package:game_app/views/constants/index.dart';
import 'package:http/http.dart' as http;

class AboutUsModel {
  final int? id;
  final String? name;
  final String? link;
  final bool? pageShow;
  final String? icon;
  AboutUsModel({
    this.id,
    this.name,
    this.pageShow,
    this.link,
    this.icon,
  });

  factory AboutUsModel.fromJson(Map<dynamic, dynamic> json) {
    return AboutUsModel(name: json['name'] as String, pageShow: json['pageshow'] as bool, link: json['link'] as String, icon: json['icon'] as String, id: json['id'] as int);
  }

  Future<List<AboutUsModel>> getAboutUs() async {
    final List<AboutUsModel> tournamentList = [];

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/about/getAboutMe/',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);

      for (final Map product in responseJson) {
        tournamentList.add(AboutUsModel.fromJson(product));
      }
      return tournamentList;
    } else {
      return [];
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
