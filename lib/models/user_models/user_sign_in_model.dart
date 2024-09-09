// ignore_for_file: file_names, always_use_package_imports, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:game_app/models/user_models/referal_model.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:http/http.dart' as http;

import 'auth_model.dart';

class UserSignInModel {
  final String? name;
  final int? ownerId;
  final String? phoneNumber;
  UserSignInModel({this.name, this.phoneNumber, this.ownerId});

  factory UserSignInModel.fromJson(Map<String, dynamic> json) {
    return UserSignInModel(name: json['fullname'] as String, phoneNumber: json['phone'] as String, ownerId: json['owner_id'] as int);
  }

  Future signUp({
    String? username,
    String? pubgID,
    String? phoneNumber,
    String? referalCode,
  }) async {
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(phoneNumber!);

    final response = await http.post(
      Uri.parse(emailValid ? '$serverURL/api/accounts/gsignup/' : '$serverURL/api/accounts/signup/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: emailValid
          ? jsonEncode(<String, dynamic>{
              'email': phoneNumber,
              'pubg_username': username,
              'pubg_id': pubgID,
              'used_ref_code': referalCode,
            })
          : jsonEncode(<String, dynamic>{
              'phone': phoneNumber,
              'pubg_username': username,
              'pubg_id': pubgID,
              'used_ref_code': referalCode,
            }),
    );

    return response.statusCode;
  }

  Future otpCheck({
    String? otp,
    String? phoneNumber,
  }) async {
    final response = await http.post(
      Uri.parse('$serverURL/api/accounts/otp-check/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'otp': otp,
        'phone': phoneNumber,
      }),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      await Auth().setToken(responseJson['access_token']);
      await Auth().setRefreshToken(responseJson['refresh_token']);
      Get.find<SettingsController>().loginUser.value = true;
      return true;
    } else {
      return response.statusCode;
    }
  }

  Future gmailOtpCheck({
    String? otp,
    String? email,
  }) async {
    print("OOOOOOOOOOOOOOOOOOOOOOOOOO");
    print(email);
    final response = await http.post(
      Uri.parse('$serverURL/api/accounts/gotp-check/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'otp': otp,
      }),
    );
    print("WWWWWWWWWWWWWWWWWWWWWWWWWW");
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      await Auth().setToken(responseJson['access_token']);
      await Auth().setRefreshToken(responseJson['refresh_token']);
      Get.find<SettingsController>().loginUser.value = true;
      return true;
    } else {
      return response.statusCode;
    }
  }

  Future login({
    required String phone,
  }) async {
    final response = await http.post(
      Uri.parse('$serverURL/api/accounts/signin/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phone,
      }),
    );
    return response.statusCode;
  }

  Future gmailLogin({
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('$serverURL/api/accounts/gsignin/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    return response.statusCode;
  }
}

class GetMeModel {
  final String? bgImage;
  final String? bio;
  final String? createdDate;
  final String? email;
  final String? firstName;
  final bool? forSale;
  final int? id;
  final String? image;
  final String? lastName;
  final int? location;
  final String? nickname;
  final String? phone;
  final String? points;
  final String? pointsFromTurnir;
  final String? price;
  final String? pubgId;
  final int? pubgType;
  final String? updatedDate;
  final int? user;
  final bool? verified;
  final bool? vip;
  final bool? blocked;
  final String? ref_code;
  final String? used_ref_code;
  GetMeModel(
      {this.id,
      this.pubgType,
      this.vip,
      this.blocked,
      this.bgImage,
      this.location,
      this.user,
      this.verified,
      this.forSale,
      this.bio,
      this.createdDate,
      this.email,
      this.firstName,
      this.image,
      this.lastName,
      this.nickname,
      this.phone,
      this.points,
      this.pointsFromTurnir,
      this.price,
      this.pubgId,
      this.updatedDate,
      this.ref_code,
      this.used_ref_code});

  factory GetMeModel.fromJson(Map<dynamic, dynamic> json) {
    return GetMeModel(
      id: json['id'] ?? 0,
      pubgType: json['pubg_type'] ?? 0,
      lastName: json['last_name'] ?? 'null',
      verified: json['verified'] ?? false,
      forSale: json['for_sale'] ?? false,
      blocked: json['blocked'] ?? false,
      bgImage: json['bg_image'] ?? 'null',
      bio: json['bio'] ?? 'null',
      createdDate: json['created_date'] ?? 'null',
      email: json['email'] ?? 'null',
      vip: json['vip'] ?? false,
      user: json['user'] ?? 0,
      location: json['location'] ?? 0,
      firstName: json['first_name'] ?? 'null',
      image: json['image'] ?? 'null',
      nickname: json['pubg_username'] ?? 'null',
      phone: json['phone'] ?? 'null',
      points: json['points'] ?? 'null',
      used_ref_code: json['used_ref_code'] ?? '',
      ref_code: json['ref_code'] ?? '',
      pointsFromTurnir: json['points_from_turnir'] ?? 'null',
      price: json['price'] ?? 'null',
      pubgId: json['pubg_id'] ?? 'null',
      updatedDate: json['updated_date'] ?? 'null',
    );
  }

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'pubgType': pubgType,
  //       'lastName': lastName,
  //       'verified': verified,
  //       'forSale': forSale,
  //       'bgImage': bgImage,
  //       'bio': bio,
  //       'createdDate': createdDate,
  //       'email': email,
  //       'vip': vip,
  //       'user': user,
  //       'location': location,
  //       'firstName': firstName,
  //       'image': image,
  //       'nickname': nickname,
  //       'phone': phone,
  //       'points': points,
  //       'used_ref_code': used_ref_code,
  //       'ref_code': ref_code,
  //       'pointsFromTurnir': pointsFromTurnir,
  //       'price': price,
  //       'pubgId': pubgId,
  //       'updatedDate': updatedDate,
  //     };

  Future<GetMeModel> getMe() async {
    final token = await Auth().getToken();
    print(token.toString());
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/accounts/get-my-account/',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      return GetMeModel.fromJson(responseJson);
    } else {
      return GetMeModel();
    }
  }

  Future<List<ReferalModel>> getReferal() async {
    try {
      final token = await Auth().getToken();

      final response = await http.get(
        Uri.parse(
          '$serverURL/api/accounts/referal/',
        ),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      var dioResponse = json.decode(response.body);

      List<dynamic> decoded = dioResponse;
      var clients = decoded.map<ReferalModel>((e) => ReferalModel.fromJson(e)).toList();

      return clients;
    } catch (e) {
      throw e;
    }
  }

  Future shortUpdate({
    required String pubgUserName,
    required String pubgUserId,
  }) async {
    final token = await Auth().getToken();
    print(token.toString());
    final response = await http.post(
      Uri.parse('$serverURL/api/accounts/short-update/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'pubg_username': pubgUserName,
        'pubg_id': pubgUserId,
      }),
    );
    return response.statusCode;
  }

  Future shortUpdateImage({
    required String pubgUserName,
    required String pubgUserId,
  }) async {
    final token = await Auth().getToken();
    print(token.toString());
    final response = await http.post(
      Uri.parse('$serverURL/api/accounts/short-update/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'pubg_username': pubgUserName,
        'pubg_id': pubgUserId,
      }),
    );
    return response.statusCode;
  }
}
