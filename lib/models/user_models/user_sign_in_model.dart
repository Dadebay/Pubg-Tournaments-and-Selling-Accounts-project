// ignore_for_file: file_names, always_use_package_imports, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:http/http.dart' as http;

import 'auth_model.dart';

class UserSignInModel {
  UserSignInModel({this.name, this.phoneNumber, this.ownerId});

  factory UserSignInModel.fromJson(Map<String, dynamic> json) {
    return UserSignInModel(name: json["fullname"] as String, phoneNumber: json["phone"] as String, ownerId: json['owner_id'] as int);
  }

  final String? name;
  final int? ownerId;
  final String? phoneNumber;

  Future signUp({
    String? username,
    String? pubgID,
    String? phoneNumber,
  }) async {
    final response = await http.post(Uri.parse("$serverURL/api/accounts/signup/"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "phone": phoneNumber,
          "pubg_username": username,
          "pubg_id": pubgID,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return response.statusCode;
    }
  }

  Future otpCheck({
    String? otp,
    String? phoneNumber,
  }) async {
    final response = await http.post(Uri.parse("$serverURL/api/accounts/otp-check/"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "otp": otp,
          "phone": phoneNumber,
        }));
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      Auth().setToken(responseJson["access_token"]);
      Auth().setRefreshToken(responseJson["refresh_token"]);
      Get.find<SettingsController>().loginUser.value = true;
      return true;
    } else {
      return response.statusCode;
    }
  }

  Future login({
    required String phone,
  }) async {
    final response = await http.post(Uri.parse("$serverURL/api/accounts/signin/"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "phone": phone,
        }));
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return response.statusCode;
    }
  }
}

class GetMeModel extends GetxController {
  GetMeModel({this.id, this.pubgType, this.vip, this.location, this.user, this.verified, this.forSale, this.bio, this.createdDate, this.email, this.firstName, this.image, this.lastName, this.nickname, this.phone, this.points, this.pointsFromTurnir, this.price, this.pubgId, this.updatedDate});

  factory GetMeModel.fromJson(Map<dynamic, dynamic> json) {
    return GetMeModel(
      id: json["id"],
      pubgType: json["pubg_type"],
      lastName: json["last_name"],
      verified: json["verified"],
      forSale: json["for_sale"],
      bio: json["bio"],
      createdDate: json["created_date"],
      email: json["email"],
      vip: json["vip"],
      user: json["user"],
      location: json["location"],
      firstName: json["first_name"],
      image: json["image"],
      nickname: json["pubg_username"],
      phone: json["phone"],
      points: json["points"],
      pointsFromTurnir: json["points_from_turnir"],
      price: json["price"],
      pubgId: json["pubg_id"],
      updatedDate: json["updated_date"],
    );
  }

  final int? id;
  final String? nickname;

  final int? pubgType;
  final int? location;
  final int? user;
  final bool? verified;
  final bool? forSale;
  final bool? vip;
  final String? phone;
  final String? bio;
  final String? points;

  final String? createdDate;
  final String? email;
  final String? firstName;
  final String? lastName;

  final String? image;
  final String? pointsFromTurnir;
  final String? price;
  final String? pubgId;
  final String? updatedDate;
  Future<GetMeModel> getMe() async {
    final token = await Auth().getToken();
    final response = await http.get(
        Uri.parse(
          "$serverURL/api/accounts/get-my-account/",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      return GetMeModel.fromJson(responseJson);
    } else {
      return GetMeModel();
    }
  }

  Future shortUpdate({
    required String pubgUserName,
    required String pubgUserId,
  }) async {
    final token = await Auth().getToken();
    final response = await http.post(Uri.parse("$serverURL/api/accounts/short-update/"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "pubg_username": pubgUserName,
          "pubg_id": pubgUserId,
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
