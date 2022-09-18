// ignore_for_file: deprecated_member_use, duplicate_ignore, implementation_imports, avoid_positional_boolean_parameters, unnecessary_null_comparison, always_use_package_imports

import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/views/other_pages/show_all_acconts.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

SnackbarController showSnackBar(String title, String subtitle, Color color) {
  return Get.snackbar(
    title,
    subtitle,
    snackStyle: SnackStyle.FLOATING,
    titleText: title == ''
        ? const SizedBox.shrink()
        : Text(
            title.tr,
            style: const TextStyle(fontFamily: josefinSansSemiBold, fontSize: 18, color: Colors.white),
          ),
    messageText: Text(
      subtitle.tr,
      style: const TextStyle(fontFamily: josefinSansRegular, fontSize: 16, color: Colors.white),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color,
    borderRadius: 20.0,
    animationDuration: const Duration(milliseconds: 800),
    margin: const EdgeInsets.all(8),
  );
}

Padding divider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Divider(
      color: backgroundColor.withOpacity(0.4),
      thickness: 2,
    ),
  );
}

Widget dividerr() {
  return Container(
    color: Colors.grey[300],
    width: double.infinity,
    height: 1,
  );
}

Divider customDivider() {
  return const Divider(
    thickness: 1,
    color: backgroundColor,
    height: 1,
  );
}

Widget spinKit() {
  return Lottie.asset(loader, animate: true, width: 300, height: 300);
}

Widget userAppBarMoney() {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          final double a = double.parse(Get.find<WalletController>().userMoney.toString());
          return Text(a.toStringAsFixed(0), style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 23));
        }),
        const Padding(
          padding: EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          child: Text('TMT'),
        ),
      ],
    ),
  );
}

Padding listViewName(String text, bool icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: icon ? 20 : 0, left: 15, right: 15, top: icon ? 0 : 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 22, fontFamily: josefinSansSemiBold),
        ),
        icon
            ? IconButton(
                onPressed: () {
                  Get.to(
                    () => const ShowAllAccounts(
                      name: 'accountsForSale',
                      pubgID: 0,
                    ),
                  );
                },
                icon: const Icon(
                  IconlyLight.arrowRightCircle,
                  color: Colors.white,
                ),
              )
            : const SizedBox.shrink()
      ],
    ),
  );
}

CustomFooter footer() {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = const Text('');
      } else if (mode == LoadStatus.loading) {
        body = const CircularProgressIndicator(
          color: kPrimaryColor,
        );
      } else if (mode == LoadStatus.failed) {
        body = const Text('Load Failed!Click retry!');
      } else if (mode == LoadStatus.canLoading) {
        body = const Text('');
      } else {
        body = const Text('No more Data');
      }
      return SizedBox(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}
