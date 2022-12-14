// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:game_app/controllers/home_page_controller.dart';
import 'package:game_app/controllers/show_all_account_controller.dart';
import 'package:http/http.dart' as http;

import '../views/constants/index.dart';
import 'user_models/auth_model.dart';

class AccountsForSaleModel extends GetxController {
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

  AccountsForSaleModel({
    this.id,
    this.pubgType,
    this.vip,
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
  });

  factory AccountsForSaleModel.fromJson(Map<dynamic, dynamic> json) {
    return AccountsForSaleModel(
      id: json['id'],
      pubgType: json['pubg_type'],
      lastName: json['last_name'],
      verified: json['verified'],
      forSale: json['for_sale'],
      bio: json['bio'],
      createdDate: json['created_date'],
      email: json['email'],
      vip: json['vip'],
      user: json['user'],
      location: json['location'],
      firstName: json['first_name'],
      image: json['image'],
      nickname: json['pubg_username'],
      phone: json['phone'],
      points: json['points'],
      pointsFromTurnir: json['points_from_turnir'],
      price: json['price'],
      pubgId: json['pubg_id'],
      updatedDate: json['updated_date'],
    );
  }

  Future<List<AccountsForSaleModel>> getAccounts({required Map<String, String> parametrs}) async {
    final List<AccountsForSaleModel> accountList = [];
    Get.find<HomePageController>().loading.value = 0;
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/accounts/get-accounts/',
      ).replace(queryParameters: parametrs),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson['results']) {
        accountList.add(AccountsForSaleModel.fromJson(product));
        Get.find<HomePageController>().list.add(AccountsForSaleModel.fromJson(product));
      }
      Get.find<HomePageController>().loading.value = 1;
      return accountList;
    } else if (response.statusCode == 404) {
      Get.find<HomePageController>().loading.value = 1;
      Get.find<HomePageController>().pageNumber.value -= 1;
      return [];
    } else {
      Get.find<HomePageController>().loading.value = 2;
      return [];
    }
  }

  Future<List<AccountsForSaleModel>> getTypeAccounts({required Map<String, String> parametrs, required int type}) async {
    final List<AccountsForSaleModel> accountList = [];
    final ShowAllAccountsController controller = Get.put(ShowAllAccountsController());
    controller.loading.value = 0;
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/accounts/type-accounts/$type/',
      ).replace(queryParameters: parametrs),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson['results']) {
        if (AccountsForSaleModel.fromJson(product).forSale == true) {
          accountList.add(AccountsForSaleModel.fromJson(product));
          controller.list.add(AccountsForSaleModel.fromJson(product));
        }
      }
      controller.loading.value = 1;
      return accountList;
    } else if (response.statusCode == 404) {
      controller.loading.value = 1;
      controller.pageNumber.value -= 1;
      return [];
    } else {
      Get.find<HomePageController>().loading.value = 2;
      return [];
    }
  }
}

class AccountByIdModel extends GetxController {
  final String? bgImage;
  final String? bio;
  final String? createdDate;
  final String? email;
  final String? firsName;
  final bool? forSale;
  final int? id;
  final String? image;
  final String? lastName;
  final int? location;
  final String? phone;
  final String? points;
  final String? pointsFromTurnir;
  final String? price;
  final String? pubgId;
  final int? pubgType;
  final String? pubgUsername;
  final String? updatedDate;
  final int? user;
  final bool? verified;
  final bool? vip;

  AccountByIdModel({
    this.id,
    this.pubgUsername,
    this.pubgId,
    this.firsName,
    this.price,
    this.lastName,
    this.email,
    this.bgImage,
    this.phone,
    this.bio,
    this.points,
    this.pointsFromTurnir,
    this.image,
    this.forSale,
    this.verified,
    this.vip,
    this.createdDate,
    this.updatedDate,
    this.user,
    this.pubgType,
    this.location,
  });

  factory AccountByIdModel.fromJson(Map<dynamic, dynamic> json) {
    return AccountByIdModel(
      id: json['id'],
      pubgUsername: json['pubg_username'],
      pubgId: json['pubg_id'],
      firsName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      bio: json['bio'],
      points: json['points'],
      pointsFromTurnir: json['points_from_turnir'],
      image: json['image'],
      bgImage: json['bg_image'],
      forSale: json['for_sale'],
      price: json['price'],
      verified: json['verified'],
      vip: json['vip'],
      createdDate: json['created_date'],
      updatedDate: json['updated_date'],
      user: json['user'],
      pubgType: json['pubg_type'],
      location: json['location'],
    );
  }

  Future<AccountByIdModel> getAccountById(int id) async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/accounts/get-account/$id/',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      return AccountByIdModel.fromJson(responseJson);
    } else {
      return AccountByIdModel();
    }
  }

  Future<AccountByIdModel> getMe() async {
    final token = await Auth().getToken();

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
      return AccountByIdModel.fromJson(responseJson);
    } else {
      return AccountByIdModel();
    }
  }
}

class GetAccountVideos {
  final int? id;
  final String? poster;
  final String? video;
  GetAccountVideos({
    this.id,
    this.video,
    this.poster,
  });

  factory GetAccountVideos.fromJson(Map<dynamic, dynamic> json) {
    return GetAccountVideos(
      id: json['id'],
      video: json['video'],
      poster: json['poster'],
    );
  }

  Future<List<GetAccountVideos>> getVideos(int id) async {
    final List<GetAccountVideos> accountList = [];

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/accounts/get-videos/$id/',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson) {
        accountList.add(GetAccountVideos.fromJson(product));
      }
      return accountList;
    } else {
      return [];
    }
  }
}
