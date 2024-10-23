// ignore_for_file: file_names, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/models/user_models/abous_us_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/index.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

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
        child: FutureBuilder<List<AboutUsModel>>(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                  child: Text(
                    'contactInformation'.tr,
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemExtent: 80,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return simpleWidget(
                        icon: '$serverURL${snapshot.data![index].icon}',
                        name: snapshot.data![index].name!,
                        onTap: () {
                          handleLink(snapshot.data![index].link!);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void handleLink(String link) async {
    final phonePattern = RegExp(r'^\+?[0-9]+$'); // Regex to check if link is a phone number
    print(phonePattern.hasMatch(link));
    final isPhoneNumber = phonePattern.hasMatch(link);

    final Uri uri = isPhoneNumber ? Uri(scheme: 'tel', path: link) : Uri.parse(link);

    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch $link';
    }
  }

  ListTile simpleWidget({
    required String icon,
    required String name,
    required Function() onTap,
  }) {
    return ListTile(
      dense: true,
      onTap: onTap,
      minLeadingWidth: 40,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
      shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
      leading: CachedNetworkImage(
        fadeInCurve: Curves.ease,
        imageUrl: icon,
        imageBuilder: (context, imageProvider) => Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => spinKit(),
        errorWidget: (context, url, error) => Center(
          child: Text(
            'noImage'.tr,
            style: const TextStyle(color: Colors.black, fontFamily: josefinSansSemiBold),
          ),
        ),
      ),
      title: Text(
        name,
        textAlign: TextAlign.start,
        style: const TextStyle(fontFamily: josefinSansMedium, fontSize: 18, color: Colors.white),
      ),
      trailing: const Icon(
        IconlyLight.arrowRightCircle,
        color: Colors.white,
      ),
    );
  }
}
