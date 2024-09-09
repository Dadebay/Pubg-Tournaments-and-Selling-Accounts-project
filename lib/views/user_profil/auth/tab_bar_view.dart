// ignore_for_file: file_names

import '../../constants/index.dart';

import 'login.dart';
import 'sign_in.dart';

class TabBarViewPage extends StatelessWidget {
  final bool loginType;
  const TabBarViewPage({required this.loginType});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kPrimaryColorBlack,
        body: Stack(
          children: [
            SizedBox(
              width: Get.size.width,
              height: Get.size.height / 2,
              child: Center(
                child: SizedBox(
                  height: 180,
                  width: 180,
                  child: ClipRRect(
                    borderRadius: borderRadius30,
                    child: Image.asset(
                      logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: Get.size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(left: 8),
                        child: TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true,
                          indicatorColor: kPrimaryColor,
                          automaticIndicatorColorAdjustment: true,
                          labelStyle: const TextStyle(fontFamily: josefinSansMedium, fontSize: 22),
                          unselectedLabelStyle: const TextStyle(fontFamily: josefinSansRegular),
                          labelColor: Colors.white,
                          indicatorWeight: 4,
                          indicatorPadding: const EdgeInsets.only(top: 45, right: 25),
                          indicator: const BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(
                              text: 'signUp'.tr,
                            ),
                            Tab(
                              text: 'signIn'.tr,
                            )
                          ],
                        ),
                      ),
                    ),
                    customDivider(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: kPrimaryColorBlack,
                        child: TabBarView(
                          children: [
                            SingIn(
                              loginType: loginType,
                            ),
                            Login(
                              loginType: loginType,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  IconlyLight.arrowLeftCircle,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
