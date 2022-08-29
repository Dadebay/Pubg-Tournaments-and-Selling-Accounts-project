// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:game_app/controllers/tournament_controller.dart';
import 'package:http/http.dart' as http;

import 'package:game_app/constants/index.dart';

import 'user_models/auth_model.dart';

class TournamentModel {
  TournamentModel({this.id, this.awards, this.description_ru, this.description_tm, this.finish_date, this.image, this.map, this.mode, this.participated_users, this.price, this.start_date, this.title, this.winners});
  factory TournamentModel.fromJson(Map<dynamic, dynamic> json) {
    return TournamentModel(
      id: json["id"],
      price: json["price"].toString(),
      title: json["title"],
      image: json["image"],
      description_tm: json["description_tm"],
      description_ru: json["description_ru"],
      start_date: json["start_date"],
      finish_date: json["finish_date"],
      mode: json["mode"],
      map: json["map"],
      awards: ((json['awards'] ?? []) as List).map((json) => Awards.fromJson(json)).toList(),
      winners: json["winners"],
      participated_users: ((json['participated_users'] ?? []) as List).map((json) => ParticipatedUsers.fromJson(json)).toList(),
    );
  }

  final int? id;
  final String? price;
  final String? title;
  final String? description_tm;
  final String? description_ru;
  final String? image;
  final String? start_date;
  final String? finish_date;
  final String? mode;
  final String? map;
  final List<Awards>? awards;
  final List? winners;
  final List<ParticipatedUsers>? participated_users;

  Future<List<TournamentModel>> getTournaments() async {
    TournamentController controller = Get.put(TournamentController());

    controller.tournamentLoading.value = 0;
    final response = await http.get(
        Uri.parse(
          "$serverURL/api/turnirs/",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      controller.tournamentLoading.value = 2;
      var decoded = utf8.decode(response.bodyBytes);

      final responseJson = json.decode(decoded);
      log(responseJson);
      for (final Map product in responseJson["results"]) {
        controller.addToList(model: TournamentModel.fromJson(product));
      }
      return [];
    } else {
      controller.tournamentLoading.value = 1;
      return [];
    }
  }

  Future<TournamentModel> getTournamentID(int id) async {
    final response = await http.get(
        Uri.parse(
          "$serverURL/api/turnirs/turnir/$id/",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        });
    if (response.statusCode == 200) {
      var decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);

      return TournamentModel.fromJson(responseJson);
    } else {
      return TournamentModel();
    }
  }

  Future participateTournament({required int userID, required int tournamentID}) async {
    final token = await Auth().getToken();
    final response = await http.post(Uri.parse("$serverURL/api/turnirs/participate/"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "user_id": userID,
          "turnir_id": tournamentID,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}

class Awards {
  Awards({this.id, this.award, this.place, this.turnir});

  factory Awards.fromJson(Map<String, dynamic> json) {
    return Awards(
      id: json["id"],
      award: json["award"],
      place: json["place"],
      turnir: json["turnir"],
    );
  }

  final String? award;
  final int? id;
  final int? place;
  final int? turnir;
}

class ParticipatedUsers {
  ParticipatedUsers({this.id, this.account_location_ru, this.account_location_tm, this.userImage, this.userName, this.created_date, this.user, this.turnir});

  factory ParticipatedUsers.fromJson(Map<String, dynamic> json) {
    return ParticipatedUsers(id: json["id"], created_date: json["created_date"], user: json["user"], turnir: json["turnir"], userImage: json["account_image"], userName: json["account_nickname"], account_location_tm: json["account_location_tm"], account_location_ru: json["account_location_ru"]);
  }

  final String? created_date;
  final int? id;
  final int? user;
  final int? turnir;
  final String? userImage;
  final String? userName;
  final String? account_location_tm;
  final String? account_location_ru;
}
