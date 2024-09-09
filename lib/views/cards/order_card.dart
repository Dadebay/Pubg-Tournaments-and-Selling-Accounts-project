import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/views/buttons/add_cart_button.dart';
import '../../connection_check.dart';
import '../constants/index.dart';

class OrderCard extends StatefulWidget {
  final int id;
  final int count;
  final String title;
  final String image;
  final String price;
  const OrderCard({
    required this.id,
    required this.count,
    required this.title,
    required this.image,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  final WalletController walletController = Get.put(WalletController());
  @override
  void initState() {
    super.initState();
    setState(() {
      widget.count;
    });
    walletController.getUserMoney();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: borderRadius20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: borderRadius15,
              child: CachedNetworkImage(
                fadeInCurve: Curves.ease,
                imageUrl: widget.image,
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
                errorWidget: (context, url, error) => const Text('No Image'),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 17),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Get.find<WalletController>().removeCart(widget.id);

                            final double b = double.parse(widget.price);
                            final double a = Get.find<WalletController>().finalCount.value;
                            Get.find<WalletController>().finalPRice.value -= b * a;
                            print(Get.find<WalletController>().finalPRice.value);

                            // Get.find<WalletController>().finalPRice.value = 0;
                            if (Get.find<WalletController>().finalPRice.value == 0) {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConnectionCheck()));
                            }
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                          ),
                          child: Icon(
                            CupertinoIcons.xmark_circle,
                            size: 26,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      '${widget.price} TMT',
                      style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansBold, fontSize: 18),
                    ),
                  ),
                  AddCartButton(productProfil: true, id: widget.id, price: widget.price, title: widget.title, image: widget.image)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
