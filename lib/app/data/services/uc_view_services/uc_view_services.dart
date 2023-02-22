// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
import 'package:game_app/app/data/models/auth_view_models/auth_model.dart';
import 'package:http/http.dart' as http;
import '../../../constants/packages/index.dart';
import '../../models/uc_view_models/uc_card_model.dart';

class UcViewServices {
  Future addCart(List list, bool ask, String pubgID) async {
    final String? token = await Auth().getToken();
    final response = await http.post(
      Uri.parse('$serverURL/api/carts/add-cart/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{'list': list, 'ask': ask, 'pubg_id': pubgID == '' ? null : pubgID}),
    );
    return response.statusCode;
  }

  Future<List<UcCardModel>> getUCS() async {
    final List<UcCardModel> ucList = [];
    final response = await http.get(
      Uri.parse('$serverURL/api/ucs/'),
      headers: <String, String>{HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'},
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson['results']) {
        ucList.add(UcCardModel.fromJson(product));
      }
      return ucList;
    } else {
      return [];
    }
  }
}
