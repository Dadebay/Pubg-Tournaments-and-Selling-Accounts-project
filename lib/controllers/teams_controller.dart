// ignore_for_file: file_names

import 'package:game_app/models/tournament_model.dart';
import 'package:get/get.dart';

class TeamsController extends GetxController {
  RxList tournamentTeamsList = [].obs;
  // RxList tournamentFinisedList = [].obs;
  RxInt tournamentLoading = 0.obs;
  // RxBool sliverBool = false.obs;

  dynamic addToList({required List<Teams> list}) {
    tournamentTeamsList.clear();
    // tournamentFinisedList.clear();
    for (var element in list) {
      tournamentTeamsList.add({'id': element.id, 'nuber': element.number, 'turnir': element.turnir, 'teamUsers': element.teamUsers});
    }
  }
}
