import 'dart:async';

import 'package:game_app/models/tournament_model.dart';
import 'package:game_app/views/cards/card_teams_widget.dart';
import 'package:game_app/views/constants/index.dart';

import 'new_tournamet_page.dart';

// ignore: must_be_immutable
class SellctTeam extends StatefulWidget {
  TournamentModel turnir;
  SellctTeam({super.key, required this.turnir});

  @override
  State<SellctTeam> createState() => _SellctTeamState();
}

class _SellctTeamState extends State<SellctTeam> {
  int selectedTeam = 0;
  int id = 1;

  Function selectTeam(int id) {
    setState(() {
      selectedTeam = id;
    });

    return selectTeam(id);
  }

  void backTurnir() {
    setState(() {
      Timer(
        Duration(seconds: 3),
        () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NewTournamentPage()), (route) => false);

          // Navigator.of(context).pop();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.turnir.teams!.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Teams'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: widget.turnir.teams!.length,
            itemBuilder: (BuildContext context, int index) {
              // return TeamsCard(team: widget.turnir.teams![index]);
              return Container(
                width: double.infinity,
                // height: 400,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: CardTeansAll(
                    teams: widget.turnir.teams![index],
                    selectedTeam: selectedTeam,
                    selectTeam: (int id) {
                      setState(() {
                        selectedTeam = id;
                      });
                      print('fhfhfhfhhffhhhfhfhh');
                      print(id);
                    },
                    usersCount: widget.turnir.type! == "solo"
                        ? 1
                        : widget.turnir.type! == "duo"
                            ? 2
                            : widget.turnir.type! == "squad"
                                ? 4
                                : 0),
              );
            },
          ),
          Positioned(
            bottom: 15,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                selectedTeam == 0
                    ? showSnackBar('Üns beriň!', 'Team Saýlaň!', Colors.red)
                    : TournamentModel().participateTournamentPost(teamId: selectedTeam).then((value) {
                        value == 200 ? backTurnir() : null;
                        // subscribeTurnirPost(price: widget.turnir.price!, id: widget.turnir.id!, tournamentType: widget.turnir.type.toString()) : null;
                      });
              },
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                    child: Center(
                        child: Text(
                      "Tassykla",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber[800]),
                    ))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
