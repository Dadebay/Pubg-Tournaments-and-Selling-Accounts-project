import 'dart:convert';
import 'dart:io';

import '../../../models/user_models/auth_model.dart';
import '../../../models/user_models/referal_model.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;

class ReferalRespositori {
  Future<List<ReferalModel>> getDryPortsModel() async {
    final List<ReferalModel> accountList = [];
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
      if (response.statusCode == 200) {
        final decoded = utf8.decode(response.bodyBytes);
        final responseJson = json.decode(decoded);
        for (final Map product in responseJson) {
          accountList.add(ReferalModel.fromJson(product));
        }
        return accountList;
      } else {
        return [];
      }
    } catch (e) {
      throw e;
    }
  }
}
