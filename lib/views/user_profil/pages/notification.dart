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
        itemCount: controller.notificationsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text(
                controller.notificationsList[index]['title'],
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
              ),
              collapsedIconColor: kPrimaryColor,
              collapsedTextColor: kPrimaryColor,
              childrenPadding: const EdgeInsets.all(15),
              children: [
                Text(
                  controller.notificationsList[index]['body'],
                  style: const TextStyle(fontFamily: josefinSansMedium, fontSize: 18),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
