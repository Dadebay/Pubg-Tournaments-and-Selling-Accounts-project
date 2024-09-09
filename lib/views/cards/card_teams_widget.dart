import 'package:game_app/views/cards/empty_users_card.dart';
import 'package:game_app/views/cards/team_user_card.dart';
import 'package:game_app/views/constants/index.dart';

import '../../models/tournament_model.dart';

// ignore: must_be_immutable
class CardTeansAll extends StatefulWidget {
  late Teams teams;
  late int selectedTeam;
  late Function(int id) selectTeam;
  late TeamUsers teamUsers;
  late int usersCount;
  CardTeansAll({required this.teams, required this.selectedTeam, required this.selectTeam, required this.usersCount});

  @override
  State<CardTeansAll> createState() => _CardTeansAllState();
}

class _CardTeansAllState extends State<CardTeansAll> {
  late int index = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectTeam(widget.teams.id!);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)), side: BorderSide(width: 1, color: Colors.black26)),
        // color: _selectedIndex == widget.team.id!.toInt() ? Colors.white : Colors.grey,
        color: widget.selectedTeam == widget.teams.id ? Colors.white : Colors.grey[800],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Team: ',
                    style: TextStyle(color: widget.selectedTeam == widget.teams.id ? Colors.black : Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.teams.number.toString(),
                    style: TextStyle(color: widget.selectedTeam == widget.teams.id ? Colors.black : Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                    children: [for (var i = 0; i < widget.usersCount; i++) widget.teams.teamUsers!.length >= i + 1 ? TeamUserCard(teamUsers: widget.teams.teamUsers![i]) : EmptyUsersCard()],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
