// ignore_for_file: file_names

import 'package:game_app/models/tournament_model.dart';
import 'package:get/get.dart';

class TournamentController extends GetxController {
  RxList tournamentList = [].obs;
  RxList tournamentFinisedList = [].obs;
  RxInt tournamentLoading = 0.obs;
  RxBool sliverBool = false.obs;

  dynamic addToList({required List<TournamentModel> list}) {
    tournamentList.clear();
    tournamentFinisedList.clear();
    for (var element in list) {
      final DateTime a = DateTime.parse(element.finish_date!);
      if (!a.isBefore(DateTime.now())) {
        tournamentList.add({
          'id': element.id,
          'map': element.map,
          'mode': element.mode,
          'image': element.image,
          'title': element.title,
          'price': element.price,
          'description_tm': element.description_tm,
          'description_ru': element.description_ru,
          'start_date': element.start_date,
          'finish_date': element.finish_date,
        });
      } else {
        tournamentFinisedList.add({
          'id': element.id,
          'map': element.map,
          'mode': element.mode,
          'image': element.image,
          'title': element.title,
          'price': element.price,
          'description_tm': element.description_tm,
          'description_ru': element.description_ru,
          'start_date': element.start_date,
          'finish_date': element.finish_date,
        });
      }
    }
  }
}
