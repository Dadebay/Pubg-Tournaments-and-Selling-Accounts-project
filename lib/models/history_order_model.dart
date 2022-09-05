// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:io';

import 'package:game_app/models/user_models/auth_model.dart';
import 'package:http/http.dart' as http;

import 'package:game_app/constants/index.dart';

class HistoryOrderModel {
  HistoryOrderModel({this.id, this.status, this.created_date, this.note, this.price});

  factory HistoryOrderModel.fromJson(Map<dynamic, dynamic> json) {
    return HistoryOrderModel(id: json["id"], status: json["status"] ?? "pending", price: json['price'].toString(), note: json['note'] ?? "", created_date: json["created_date"]);
  }

  final int? id;
  final String? status;
  final String? created_date;
  final String? price;
  final String? note;

  Future<List<HistoryOrderModel>> getOrders() async {
    final token = await Auth().getToken();
    final List<HistoryOrderModel> tournamentList = [];
    final response = await http.get(
        Uri.parse(
          "$serverURL/api/carts/",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson) {
        tournamentList.add(HistoryOrderModel.fromJson(product));
      }

      return tournamentList;
    } else {
      return [];
    }
  }
}

class HistoryIDModel {
  HistoryIDModel({this.id, this.status, this.created_date, this.note, this.price, this.cartItems});

  factory HistoryIDModel.fromJson(Map<dynamic, dynamic> json) {
    return HistoryIDModel(
      id: json["id"],
      status: json["status"] ?? "pending",
      price: json['price'].toString(),
      note: json['note'] ?? "",
      created_date: json["created_date"],
      cartItems: ((json['cart_items'] ?? []) as List).map((json) => CartItems.fromJson(json)).toList(),
    );
  }

  final int? id;
  final String? price;
  final String? status;
  final String? note;
  final String? created_date;
  final List<CartItems>? cartItems;
  Future<HistoryIDModel> getOrderByID(int id) async {
    final token = await Auth().getToken();

    final response = await http.get(
        Uri.parse(
          "$serverURL/api/carts/get-cart/$id/",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      return HistoryIDModel.fromJson(responseJson);
    } else {
      return HistoryIDModel();
    }
  }
}

class CartItems {
  CartItems({this.id, this.code, this.count, this.ucImage, this.ucName});

  factory CartItems.fromJson(Map<String, dynamic> json) {
    return CartItems(id: json["id"], code: json["code"], count: json["count"], ucImage: json["image"], ucName: json["name"]);
  }

  final int? id;
  final int? count;
  final String? code;
  final String? ucName;
  final String? ucImage;
}

class TransactionHistoryModel {
  TransactionHistoryModel({
    this.id,
    this.count,
    this.fromTurnir,
    this.created_date,
  });

  factory TransactionHistoryModel.fromJson(Map<dynamic, dynamic> json) {
    return TransactionHistoryModel(
      id: json["id"],
      count: json["count"],
      fromTurnir: json["from_turnir"],
      created_date: json["created_date"],
    );
  }

  final int? id;
  final String? count;
  final bool? fromTurnir;
  final String? created_date;
  Future<List<TransactionHistoryModel>> getTransactions() async {
    final token = await Auth().getToken();
    final List<TransactionHistoryModel> tournamentList = [];
    final response = await http.get(
        Uri.parse(
          "$serverURL/api/accounts/points/",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson) {
        tournamentList.add(TransactionHistoryModel.fromJson(product));
      }

      return tournamentList;
    } else {
      return [];
    }
  }

  Future requestCash({
    required String fullname,
    required String phone,
    required String message,
  }) async {
    final token = await Auth().getToken();
    final response = await http.post(Uri.parse("$serverURL/api/about/add-message/"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "phone": phone,
          "name": fullname,
          "message": message,
        }));
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
