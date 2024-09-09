import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/widgets.dart';

class OtherUserProductProfil extends StatelessWidget {
  final String? points;
  final String? name;
  final String? image;
  final int index;
  OtherUserProductProfil({
    super.key,
    required this.name,
    required this.image,
    required this.index,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(name!),
      ),
      body: name != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)), side: BorderSide(width: 1, color: Colors.black26)),
                    child: Container(
                      width: double.infinity,
                      height: 220,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ClipOval(
                              child: SizedBox(
                                width: 90,
                                height: 100,
                                child: CachedNetworkImage(
                                  fadeInCurve: Curves.ease,
                                  imageUrl: image!,
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Center(child: spinKit()),
                                  errorWidget: (context, url, error) => Container(
                                    color: kPrimaryColor.withOpacity(0.2),
                                    child: const Center(
                                      child: Text(
                                        'Surat ýok',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '  $name',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 24),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)), side: BorderSide(width: 1, color: Colors.black26)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Points ',
                              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                            ),
                            Text(
                              points!.substring(0, 5),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.end,
                              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Text('Other user product proifil'),
            ),
    );
  }
}
