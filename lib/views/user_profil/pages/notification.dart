import 'package:game_app/views/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';

class NotificationPage extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(fontSize: 18.0, backArrow: true, iconRemove: false, name: 'notification', elevationWhite: true),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text(
                'Medetden cekdimeli',
                style: TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
              ),
              collapsedIconColor: kPrimaryColor,
              collapsedTextColor: kPrimaryColor,
              childrenPadding: EdgeInsets.all(15),
              children: [
                Text(
                  'Tayyn edenson Medetden almalyu',
                  style: TextStyle(fontFamily: josefinSansMedium, fontSize: 18),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
