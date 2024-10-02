import 'package:game_app/views/constants/index.dart';

import '../../models/tournament_model.dart';

// ignore: must_be_immutable
class GatnashyanlarCard extends StatefulWidget {
  // late Teams team;
  late TeamUsers teamUsers;
  late String turnirType;
  GatnashyanlarCard({required this.teamUsers});

  @override
  State<GatnashyanlarCard> createState() => _GatnashyanlarCardState();
}

class _GatnashyanlarCardState extends State<GatnashyanlarCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: borderRadius15),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: borderRadius15),
            margin: EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border
              child: SizedBox(
                width: 60,
                height: 60,
                child: widget.teamUsers.user!.image == null ? Icon(IconlyLight.user3) : Image.network('$serverURL/${widget.teamUsers.user!.image}', fit: BoxFit.cover),
              ),
            ),
          ),
          Text(
            widget.teamUsers.user!.nickname.toString(),
            style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: josefinSansSemiBold),
          )
        ],
      ),
    );
  }
} 
