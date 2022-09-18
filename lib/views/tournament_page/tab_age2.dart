// ignore_for_file: file_names, must_be_immutable

import 'package:game_app/constants/index.dart';
import 'package:game_app/models/tournament_model.dart';

class TabPage2 extends StatelessWidget {
  final TournamentModel model;

  const TabPage2({
    required this.model,
    Key? key,
  }) : super(key: key);

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
                  ' ${index + 1} )',
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  model.awards![index].award.toString().substring(0, model.awards![index].award!.length - 3) + ' TMT',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: josefinSansRegular),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
