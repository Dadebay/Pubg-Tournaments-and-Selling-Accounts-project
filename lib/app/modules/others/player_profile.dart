import 'package:game_app/app/constants/others/app_bar.dart';
import 'package:game_app/app/constants/packages/index.dart';

class PlayerProfil extends StatelessWidget {
  const PlayerProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(fontSize: 0.0, backArrow: true, iconRemove: false, name: 'Player Profile', elevationWhite: false),
    );
  }
}
