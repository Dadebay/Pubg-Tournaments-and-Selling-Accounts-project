import 'package:cached_network_image/cached_network_image.dart';

import '../constants/index.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: Get.size.width,
      decoration: const BoxDecoration(borderRadius: borderRadius15),
      child: ClipRRect(
        borderRadius: borderRadius15,
        child: CachedNetworkImage(
            fadeInCurve: Curves.ease,
            imageUrl: image,
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
            errorWidget: (context, url, error) => noBannerImage()),
      ),
    );
  }
}
