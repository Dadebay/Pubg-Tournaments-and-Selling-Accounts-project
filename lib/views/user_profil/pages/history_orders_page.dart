// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:game_app/models/history_order_model.dart';

class HistoryOrdersPage extends StatelessWidget {
  const HistoryOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(backArrow: true, fontSize: 0.0, elevationWhite: true, iconRemove: true, name: 'orders'),
      body: FutureBuilder<List<HistoryOrderModel>>(
        future: HistoryOrderModel().getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return errorData(
              onTap: () {
                HistoryOrderModel().getOrders();
              },
            );
          } else if (snapshot.data == null) {
            return emptyData();
          } else if (snapshot.data.toString() == '[]') {
            return noData('noOrder');
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Get.to(
                    () => OrderByID(
                      orderID: snapshot.data![index].id!,
                      pageName: '${'orderPage'.tr} ${snapshot.data!.length - index}',
                      ask: snapshot.data![index].ask!,
                    ),
                  );
                },
                title: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6, bottom: 4),
                            child: Icon(
                              snapshot.data![index].status == 'pending' ? IconlyLight.timeCircle : Icons.done_all,
                              color: snapshot.data![index].status == 'pending' ? kPrimaryColor : Colors.green,
                              size: 24,
                            ),
                          ),
                          Text(
                            // 'orderPage'.tr + ' ${snapshot.data![index].id}',
                            '${'orderPage'.tr} ${snapshot.data!.length - index}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: josefinSansMedium,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          snapshot.data![index].created_date.toString().substring(0, 10),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontFamily: josefinSansRegular,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${snapshot.data![index].price} TMT',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: josefinSansMedium,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                iconColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                trailing: const Icon(
                  IconlyLight.arrowRightCircle,
                  color: Colors.white,
                  size: 20,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OrderByID extends StatelessWidget {
  final int orderID;
  final String pageName;
  final bool ask;
  const OrderByID({
    required this.orderID,
    required this.pageName,
    required this.ask,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: MyAppBar(backArrow: true, fontSize: 0.0, elevationWhite: true, iconRemove: true, name: pageName),
      body: FutureBuilder<HistoryIDModel>(
        future: HistoryIDModel().getOrderByID(orderID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return errorData(onTap: () {
              HistoryIDModel().getOrderByID(orderID);
            });
          } else if (snapshot.data == null) {
            return emptyData();
          } else if (snapshot.data.toString() == '[]') {
            return noData('noOrder');
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.cartItems!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      title: Row(
                        children: [
                          ClipRRect(
                            borderRadius: borderRadius15,
                            child: CachedNetworkImage(
                              fadeInCurve: Curves.ease,
                              imageUrl: '$serverURL${snapshot.data!.cartItems![index].ucImage}',
                              imageBuilder: (context, imageProvider) => Container(
                                width: 75,
                                height: 75,
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(snapshot.data!.cartItems![index].ucName.toString(), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16)),
                                  ),
                                  Text('orderPage1'.tr + snapshot.data!.cartItems![index].count.toString(), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey, fontFamily: josefinSansMedium, fontSize: 14)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      collapsedIconColor: kPrimaryColor,
                      collapsedTextColor: kPrimaryColor,
                      childrenPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(flex: 1, child: Text('${'tournamentInfo7'.tr} ', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 18))),
                                  Expanded(flex: 3, child: Text(snapshot.data!.created_date!.substring(0, 10), textAlign: TextAlign.start, style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansMedium, fontSize: 18))),
                                ],
                              ),
                            ),
                            ask
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Expanded(flex: 1, child: Text('${'tournamentInfo15'.tr} :  ', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 18))),
                                        Expanded(
                                          flex: 3,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: snapshot.data!.cartItems![index].code!.length,
                                            itemBuilder: (BuildContext context, int indexx) {
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(child: Text(snapshot.data!.cartItems![index].code![indexx].code ?? 'tournamentInfo10'.tr, textAlign: TextAlign.start, style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansMedium, fontSize: 18))),
                                                  ElevatedButton.icon(
                                                    onPressed: () {
                                                      Clipboard.setData(ClipboardData(text: snapshot.data!.cartItems![index].code![indexx].code.toString())).then((value) {
                                                        showSnackBar('copySucces', 'copySuccesSubtitle', Colors.green);
                                                      });
                                                    },
                                                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColorBlack, elevation: 0.0, side: const BorderSide(color: kPrimaryColor)),
                                                    icon: const Icon(
                                                      Icons.copy_all,
                                                      color: Colors.white,
                                                    ),
                                                    label: Text(
                                                      'copy'.tr,
                                                      style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            ask
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Expanded(flex: 1, child: Text('${'signIn2'.tr} :  ', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 18))),
                                        Expanded(flex: 3, child: Text(snapshot.data!.pubgID ?? 'tournamentInfo10'.tr, textAlign: TextAlign.start, style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansMedium, fontSize: 18))),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            snapshot.data!.note != null
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Expanded(flex: 1, child: Text('${'note'.tr} :  ', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 18))),
                                        Expanded(flex: 3, child: Text(snapshot.data!.note ?? 'tournamentInfo10'.tr, textAlign: TextAlign.start, style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansMedium, fontSize: 18))),
                                      ],
                                    ),
                                  )
                                : ask
                                    ? Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          children: [
                                            Expanded(flex: 1, child: Text('${'note'.tr} :  ', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 18))),
                                            Expanded(flex: 3, child: Text(snapshot.data!.note ?? 'tournamentInfo10'.tr, textAlign: TextAlign.start, style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansMedium, fontSize: 18))),
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                          ],
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
