// ignore_for_file: deprecated_member_use, file_names, avoid_types_as_parameter_names, non_constant_identifier_names, must_be_immutable, avoid_dynamic_calls, unnecessary_null_checks, use_key_in_widget_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/SettingsController.dart';
import 'package:game_app/models/HomePageModel.dart';

class Banners extends StatelessWidget {
  final Future<List<HomePageModel>> future;

  const Banners({Key? key, required this.future}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HomePageModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(margin: const EdgeInsets.all(8), height: 220, width: Get.size.width, decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.4)), child: Center(child: spinKit()));
          } else if (snapshot.hasError) {
            return noImage();
          } else if (snapshot.data.toString() == "[]") {
            return noImage();
          }
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index, count) {
                  return GestureDetector(
                    onTap: () {
                      // int page = 0;
                      // int id = 0;
                      // for (int i = 0; i < snapshot.data![index].url!.length; i++) {
                      //   if (snapshot.data![index].url![i] == "/") page = int.parse(snapshot.data![index].url![i + 1]);
                      // }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: Get.size.width,
                      decoration: const BoxDecoration(borderRadius: borderRadius15),
                      child: ClipRRect(
                        borderRadius: borderRadius15,
                        child: CachedNetworkImage(
                            fadeInCurve: Curves.ease,
                            imageUrl: "$serverURL${snapshot.data![index].image}",
                            imageBuilder: (context, imageProvider) => Container(
                                  width: Get.size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: borderRadius20,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            placeholder: (context, url) => Center(child: spinKit()),
                            errorWidget: (context, url, error) => noImage()),
                      ),
                    ),
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
              SizedBox(
                height: 20,
                width: Get.size.width,
                child: Center(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Obx(() {
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
                            }),
                          );
                        })),
              )
            ],
          );
        });
  }

  Container noImage() {
    return Container(
        margin: const EdgeInsets.all(15),
        width: Get.size.width,
        height: 220,
        decoration: const BoxDecoration(borderRadius: borderRadius15, color: kPrimaryColorBlack1),
        child: Center(
            child: Text(
          "noImageBanner".tr,
          style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
        )));
  }
}
