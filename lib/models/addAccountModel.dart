// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:game_app/constants/index.dart';
import 'package:game_app/models/UserModels/AuthModel.dart';
import 'package:http/http.dart' as http;

class AddAccountModel extends GetxController {
  AddAccountModel({
    this.id,
    this.pubgType,
    this.vip,
    this.location,
    this.forSale,
    this.bio,
    this.email,
    this.firstName,
    this.image,
    this.lastName,
    this.nickname,
    this.phone,
    this.price,
    this.pubgId,
  });

  factory AddAccountModel.fromJson(Map<dynamic, dynamic> json) {
    return AddAccountModel(
      id: json["id"],
      pubgType: json["pubg_type"],
      lastName: json["last_name"],
      forSale: json["for_sale"],
      bio: json["bio"],
      email: json["email"],
      vip: json["vip"],
      location: json["location"],
      firstName: json["first_name"],
      image: json["image"],
      nickname: json["pubg_username"],
      phone: json["phone"],
      price: json["price"],
      pubgId: json["pubg_id"],
    );
  }

  final int? id;
  final String? nickname;
  final int? pubgType;
  final int? location;
  final bool? forSale;
  final bool? vip;
  final String? phone;
  final String? bio;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? image;
  final String? price;
  final String? pubgId;

  Future sendData(Map<String, dynamic> body) async {
    final token = await Auth().getToken();
    print(token);
    //  FormData formData = FormData.;
    final response = await http.post(Uri.parse("$serverURL/api/accounts/update-account/"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(body));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
