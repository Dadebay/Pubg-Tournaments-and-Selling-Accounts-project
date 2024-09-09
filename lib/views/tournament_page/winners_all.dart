import 'package:flutter/material.dart';

import '../../models/tournament_model.dart';
import '../cards/empty_users_card.dart';
import '../cards/gatnashyanlar_card.dart';

// ignore: must_be_immutable
class WinnersAll extends StatefulWidget {
  late Winners winners;
  late Awards awards;
  TeamUsers team_users;

  late Teams teamUsers;
  late int usersCount;

  WinnersAll({required this.winners, required this.usersCount, required this.team_users});

  @override
  State<WinnersAll> createState() => _WinnersAllState();
}

class _WinnersAllState extends State<WinnersAll> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: _selectedIndex == widget.team.id!.toInt() ? Colors.white : Colors.grey,
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)), side: BorderSide(width: 1, color: Colors.black26)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Team: ',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.winners.team_number.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                // height: 310,
                width: double.infinity,
                child: Column(
                  children: [for (var i = 0; i < widget.usersCount; i++) widget.winners.teamUsers!.length >= i + 1 ? GatnashyanlarCard(teamUsers: widget.winners.teamUsers![i]) : EmptyUsersCard()],
                )),
          )
        ],
      ),
    );
  }
}
