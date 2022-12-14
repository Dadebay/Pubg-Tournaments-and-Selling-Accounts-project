// ignore_for_file: file_names
import 'package:game_app/views/constants/index.dart';

import 'local_widgets.dart';

class NewTournamentPage extends StatefulWidget {
  const NewTournamentPage({Key? key}) : super(key: key);

  @override
  State<NewTournamentPage> createState() => _NewTournamentPageState();
}

class _NewTournamentPageState extends State<NewTournamentPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          fontSize: 22.0,
          backArrow: false,
          iconRemove: false,
          name: 'tournament',
          elevationWhite: true,
        ),
        backgroundColor: kPrimaryColorBlack,
        body: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemExtent: 220,
          itemCount: 3,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return tournamentCard(index);
          },
        ),
      ),
    );
  }
}
