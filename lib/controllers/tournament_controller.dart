// ignore_for_file: file_names

import 'package:game_app/models/tournament_model.dart';
import 'package:get/get.dart';

class TournamentController extends GetxController {
  late Future<List<TournamentModel>> getTournaments;
  RxList tournamentList = [].obs;
  RxList tournamentFinisedList = [].obs;
  RxInt tournamentLoading = 0.obs;
  RxBool sliverBool = false.obs;

  dynamic addToList({required TournamentModel model}) {
    tournamentList.clear();
    tournamentFinisedList.clear();
    DateTime a = DateTime.parse(model.start_date!);
    if (a.month >= DateTime.now().month && a.day >= DateTime.now().day) {
      tournamentList.add({
        "id": model.id,
        "map": model.map,
        "mode": model.mode,
        "image": model.image,
        "title": model.title,
        "price": model.price,
        "description_tm": model.description_tm,
        "description_ru": model.description_ru,
        "start_date": model.start_date,
        "finish_date": model.finish_date,
      });
    } else {
      tournamentFinisedList.add({
        "id": model.id,
        "map": model.map,
        "mode": model.mode,
        "image": model.image,
        "title": model.title,
        "price": model.price,
        "description_tm": model.description_tm,
        "description_ru": model.description_ru,
        "start_date": model.start_date,
        "finish_date": model.finish_date,
      });
    }
  }
}
