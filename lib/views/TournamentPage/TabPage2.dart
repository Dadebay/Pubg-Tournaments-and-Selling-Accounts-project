// ignore_for_file: file_names, must_be_immutable

import 'package:game_app/constants/index.dart';
import 'package:game_app/models/TournamentModel.dart';

class TabPage2 extends StatelessWidget {
  final TournamentModel model;

  List icons = [
    "assets/icons/tier/1.png",
    "assets/icons/tier/2.png",
    "assets/icons/tier/3.png",
  ];

  TabPage2({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model.awards!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            tileColor: index % 2 == 0 ? kPrimaryColorBlack : kPrimaryColorBlack1,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    " ${index + 1} )",
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    model.awards![index].award.toString() + " UC",
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
