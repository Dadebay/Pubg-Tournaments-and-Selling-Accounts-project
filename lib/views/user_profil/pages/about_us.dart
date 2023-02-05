// ignore_for_file: file_names

import 'package:game_app/models/user_models/abous_us_model.dart';
import '../../constants/index.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(
        backArrow: true,
        iconRemove: true,
        elevationWhite: true,
        name: 'aboutUs',
        fontSize: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(14.0),
        child: FutureBuilder<AboutUsModel>(
          future: AboutUsModel().getAboutUs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: spinKit());
            } else if (snapshot.hasError) {
              return errorData(
                onTap: () {
                  AboutUsModel().getAboutUs();
                },
              );
            } else if (snapshot.data == null) {
              return emptyData();
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                  child: Text(
                    'contactInformation'.tr,
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                  ),
                ),
                simpleWidget(
                  icon: IconlyBold.message,
                  name: snapshot.data!.email!,
                ),
                simpleWidget(
                  icon: IconlyBold.location,
                  name: Get.locale?.languageCode == 'tr' ? snapshot.data!.address_tm! : snapshot.data!.address_ru!,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ListTile simpleWidget({
    required IconData icon,
    required String name,
  }) {
    return ListTile(
      dense: true,
      onTap: () async {},
      minLeadingWidth: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
      shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
      leading: Icon(
        icon,
        color: kPrimaryColor,
      ),
      title: Text(
        name,
        textAlign: TextAlign.start,
        style: const TextStyle(fontFamily: josefinSansMedium, fontSize: 18, color: Colors.white),
      ),
    );
  }
}
