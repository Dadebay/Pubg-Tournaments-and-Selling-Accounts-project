import 'index.dart';

ListView waitingData() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: 10,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return Container(
        margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
        height: 170,
        decoration: BoxDecoration(borderRadius: borderRadius15, color: kPrimaryColorBlack1.withOpacity(0.4)),
        child: Center(
          child: spinKit(),
        ),
      );
    },
  );
}

Center cannotLoadData({required bool withButton, required Function() onTap, required String text}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            text, // withButton ? "errorPubgAccounts".tr : "Hic Hilis satlyk akkaunt yok",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: josefinSansMedium),
          ),
        ),
        withButton
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                child: Text(
                  'noConnection3'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: josefinSansMedium),
                ),
              )
            : const SizedBox.shrink()
      ],
    ),
  );
}

Container noBannerImage() {
  return Container(
    margin: const EdgeInsets.all(15),
    width: Get.size.width,
    height: 220,
    decoration: const BoxDecoration(borderRadius: borderRadius15, color: kPrimaryColorBlack1),
    child: Center(
      child: Text(
        'noImageBanner'.tr,
        style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
      ),
    ),
  );
}

Center noData(String text) {
  return Center(
    child: Text(
      text.tr,
      maxLines: 2,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
    ),
  );
}
