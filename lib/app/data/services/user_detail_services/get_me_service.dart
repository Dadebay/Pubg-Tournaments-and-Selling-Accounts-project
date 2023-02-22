import 'dart:convert';

import '../../../constants/packages/index.dart';
import '../../models/auth_view_models/auth_model.dart';
import '../../models/user_detail_model/get_me_model.dart';
import 'package:http/http.dart' as http;

class GetMeServices {
  Future<GetMeModel> getMe() async {
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
      return GetMeModel.fromJson(responseJson);
    } else {
      return GetMeModel();
    }
  }
}
