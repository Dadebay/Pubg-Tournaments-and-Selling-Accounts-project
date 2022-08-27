// ignore_for_file: deprecated_member_use, duplicate_ignore, implementation_imports, avoid_positional_boolean_parameters, unnecessary_null_comparison, always_use_package_imports

import 'package:game_app/constants/index.dart';
import 'package:game_app/views/UserProfil/Pages/Cash.dart';
import 'package:lottie/lottie.dart';

SnackbarController showSnackBar(String title, String subtitle, Color color) {
  return Get.snackbar(
    title,
    subtitle,
    snackStyle: SnackStyle.FLOATING,
    titleText: title == ""
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

Widget spinKit() {
  return Lottie.asset("assets/lottie/pubg.json", animate: true, width: 300, height: 300);
}

Widget balIcon() {
  return GestureDetector(
    onTap: () {
      Get.to(() => const MyCash());
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("150", style: TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 22)),
          Padding(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Text("TMT")
              // Image.asset(
              //   "assets/icons/token.png",
              //   width: 30,
              //   fit: BoxFit.cover,
              //   height: 30,
              // ),
              ),
        ],
      ),
    ),
  );
}

customDivider() {
  return const Divider(
    thickness: 1,
    color: backgroundColor,
    height: 1,
  );
}

showDeleteDialog(BuildContext context, String text, String text2, Function() onTap) {
  showGeneralDialog(
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.decelerate.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 400, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
                backgroundColor: kPrimaryColorBlack,
                shape: const OutlineInputBorder(borderRadius: borderRadius15, borderSide: BorderSide(color: Colors.white)),
                title: Text(
                  text.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontFamily: josefinSansSemiBold),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 6, right: 6),
                      child: Text(
                        text2.tr,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: josefinSansMedium),
                      ),
                    ),
                    Row(
                      children: [
                        dialogButton("no", () {
                          Get.back();
                        }, false),
                        const SizedBox(
                          width: 10,
                        ),
                        dialogButton("yes", onTap, true),
                      ],
                    )
                  ],
                )),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox.shrink();
      });
}

//
Widget dialogButton(String name, Function() onTap, bool color) {
  return Expanded(
    child: RaisedButton(
        onPressed: onTap,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        color: kPrimaryColorBlack1,
        shape: const RoundedRectangleBorder(borderRadius: borderRadius20),
        child: Text(
          name.tr,
          style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: color ? josefinSansMedium : josefinSansSemiBold),
        )),
  );
}
