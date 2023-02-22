import 'dart:convert';

import 'package:game_app/app/data/models/constants_model/constants_model.dart';
import 'package:http/http.dart' as http;

import '../../../constants/packages/index.dart';

class ConstantsService {
  Future<ConstantsModel> getConsts() async {
    final response = await http.get(
      Uri.parse('$serverURL/api/about/consts/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      return ConstantsModel.fromJson(json.decode(decoded));
    } else {
      return ConstantsModel();
    }
  }
}
