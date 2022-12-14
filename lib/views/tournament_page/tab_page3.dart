// ignore_for_file: file_names

import 'package:game_app/models/tournament_model.dart';
import '../constants/index.dart';
import 'local_widgets.dart';

class TabPage3 extends StatelessWidget {
  final TournamentModel model;
  final int tournamentType;
  final bool finised;
  const TabPage3({
    required this.model,
    required this.finised,
    required this.tournamentType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: finised ? model.winners!.length : model.participated_users!.length,
      itemBuilder: (BuildContext context, int index) {
        if (tournamentType == 0) {
          return tab3PageTypeSolo(
            finised: finised,
            index: index,
            model: model,
          );
        } else if (tournamentType == 1) {
          return type3PageTypeDuo(index);
        } else {
          return type3PageSquad(index);
        }
      },
    );
  }
}
