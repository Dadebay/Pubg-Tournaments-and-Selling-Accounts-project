// ignore_for_file: deprecated_member_use, file_names, avoid_types_as_parameter_names, non_constant_identifier_names, must_be_immutable, avoid_dynamic_calls, unnecessary_null_checks, use_key_in_widget_constructors, avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:game_app/cards/bannerCard.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/SettingsController.dart';
import 'package:game_app/models/homePageModel.dart';

class Banners extends StatelessWidget {
  final Future<List<BannerModel>> future;

  const Banners({Key? key, required this.future}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(margin: const EdgeInsets.all(8), height: 220, width: Get.size.width, decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.4)), child: Center(child: spinKit()));
          } else if (snapshot.hasError) {
            return noBannerImage();
          } else if (snapshot.data.toString() == "[]") {
            return noBannerImage();
          }
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index, count) {
                  return BannerCard(
                    image: "$serverURL${snapshot.data![index].image}",
                  );
                },
                options: CarouselOptions(
                  onPageChanged: (index, CarouselPageChangedReason) {
                    Get.find<SettingsController>().bannerSelectedIndex.value = index;
                  },
                  height: 220,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                ),
              ),
              dots(snapshot)
            ],
          );
        });
  }

  SizedBox dots(AsyncSnapshot<List<BannerModel>> snapshot) {
    return SizedBox(
      height: 20,
      width: Get.size.width,
      child: Center(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Obx(() {
                  return AnimatedContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                    height: Get.find<SettingsController>().bannerSelectedIndex.value == index ? 16 : 10,
                    width: Get.find<SettingsController>().bannerSelectedIndex.value == index ? 15 : 10,
                    decoration: BoxDecoration(
                      color: Get.find<SettingsController>().bannerSelectedIndex.value == index ? Colors.transparent : Colors.grey,
                      shape: BoxShape.circle,
                      border: Get.find<SettingsController>().bannerSelectedIndex.value == index ? Border.all(color: kPrimaryColor, width: 3) : Border.all(color: Colors.white),
                    ),
                  );
                });
              })),
    );
  }
}
