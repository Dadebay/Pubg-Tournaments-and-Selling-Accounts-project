import 'package:game_app/views/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';

import '../../../models/notifications_model.dart';

class NotificationPage extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(fontSize: 18.0, backArrow: true, iconRemove: false, name: 'notification', elevationWhite: true),
      body: FutureBuilder<List<NotifcationModel>>(
        future: NotifcationModel().getNotifcations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return errorData(onTap: () {});
          } else if (snapshot.data.toString() == '[]') {
            return noBannerImage();
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text(
                    snapshot.data![index].title!,
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
                  ),
                  collapsedIconColor: kPrimaryColor,
                  collapsedTextColor: kPrimaryColor,
                  childrenPadding: const EdgeInsets.all(15),
                  children: [
                    Text(
                      snapshot.data![index].content!,
                      style: const TextStyle(fontFamily: josefinSansMedium, fontSize: 18),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
