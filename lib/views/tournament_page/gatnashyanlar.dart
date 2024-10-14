import '../../models/tournament_model.dart';
import '../cards/empty_users_card.dart';
import '../cards/gatnashyanlar_card.dart';
import '../constants/index.dart';

// ignore: must_be_immutable
class Gatnashyanlatr extends StatefulWidget {
  late Teams teams;
  late Awards awards;

  late Teams teamUsers;
  late int usersCount;

  Gatnashyanlatr({
    required this.teams,
    required this.usersCount,
    super.key,
  });

  @override
  State<Gatnashyanlatr> createState() => _GatnashyanlatrState();
}

class _GatnashyanlatrState extends State<Gatnashyanlatr> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryColorBlack,
      shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(25)), side: BorderSide(width: 1, color: kPrimaryColor.withOpacity(0.4))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Team: ',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: josefinSansBold),
                ),
                Text(
                  widget.teams.number.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [for (var i = 0; i < widget.usersCount; i++) widget.teams.teamUsers!.length >= i + 1 ? GatnashyanlarCard(teamUsers: widget.teams.teamUsers![i]) : const EmptyUsersCard()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
