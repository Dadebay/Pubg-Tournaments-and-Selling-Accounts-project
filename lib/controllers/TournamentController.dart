// ignore_for_file: file_names

import 'package:game_app/constants/index.dart';
import 'package:game_app/models/tournamentModel.dart';

class TournamentController extends GetxController {
  late Future<List<TournamentModel>> getTournaments;
  RxList tournamentList = [].obs;
  RxList tournamentFinisedList = [].obs;
  RxInt tournamentLoading = 0.obs;
  RxBool sliverBool = false.obs;

  getData({required List<TournamentModel> list}) {
    tournamentList.clear();
    tournamentFinisedList.clear();
    if (list.isEmpty) {
      tournamentLoading.value = 1;
    } else {
      tournamentLoading.value = 2;

      for (var element in list) {
        DateTime a = DateTime.parse(element.start_date!);

        if (a.month >= DateTime.now().month && a.day >= DateTime.now().day) {
          tournamentList.add({
            "id": element.id,
            "map": element.map,
            "mode": element.mode,
            "image": element.image,
            "title": element.title,
            "price": element.price,
            "description_tm": element.description_tm,
            "description_ru": element.description_ru,
            "start_date": element.start_date,
            "finish_date": element.finish_date,
          });
        } else {
          tournamentFinisedList.add({
            "id": element.id,
            "map": element.map,
            "mode": element.mode,
            "image": element.image,
            "title": element.title,
            "price": element.price,
            "description_tm": element.description_tm,
            "description_ru": element.description_ru,
            "start_date": element.start_date,
            "finish_date": element.finish_date,
          });
        }
      }
    }
  }
}
