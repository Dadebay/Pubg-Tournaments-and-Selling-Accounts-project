// ignore_for_file: missing_return, file_names, must_be_immutable, require_trailing_commas

import 'package:game_app/app/constants/packages/index.dart';
import 'package:game_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../constants/buttons/bottom_nav_bar_button.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  List page = [
    HomeView(),
    TournamentsView(),
    BestPlayersView(),
    PubgUcView(),
    UserProfilView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        bottomNavigationBar: Container(
          color: kPrimaryColorBlack,
          height: kBottomNavigationBarHeight,
          child: Row(
            children: [
              Expanded(
                  child: BottomNavbarButton(
                icon: false,
                index: 0,
                selectedIndex: selectedIndex,
                onTapp: () => onTapp(0),
              )),
              Expanded(
                  child: BottomNavbarButton(
                icon: false,
                index: 1,
                selectedIndex: selectedIndex,
                onTapp: () => onTapp(1),
              )),
              Expanded(
                  child: BottomNavbarButton(
                icon: true,
                index: 2,
                selectedIndex: selectedIndex,
                onTapp: () => onTapp(2),
              )),
              Expanded(
                  child: BottomNavbarButton(
                icon: false,
                index: 3,
                selectedIndex: selectedIndex,
                onTapp: () => onTapp(3),
              )),
              Expanded(
                  child: BottomNavbarButton(
                icon: false,
                index: 4,
                selectedIndex: selectedIndex,
                onTapp: () => onTapp(4),
              )),
            ],
          ),
        ),
        body: Stack(
          children: [
            Center(
              child: page[selectedIndex],
            ),
            Get.find<AuthController>().blockedUser.value ? blokedPage() : SizedBox.shrink(),
          ],
        ));
  }

  Widget blokedPage() {
    return Positioned.fill(
        child: Container(
      padding: const EdgeInsets.all(15),
      color: kPrimaryColorBlack.withOpacity(0.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'blokedTitle'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansBold, fontSize: 30),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'blokedSubtitle'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 25),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: Get.size.width,
            child: ElevatedButton(
              onPressed: () async {
                await launchUrlString('tel://+99362222307');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: const RoundedRectangleBorder(borderRadius: borderRadius15),
              ),
              child: Text(
                'popUP1'.tr,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold, fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void onTapp(int index) async {
    setState(() {
      selectedIndex = index;
    });
  }
}
