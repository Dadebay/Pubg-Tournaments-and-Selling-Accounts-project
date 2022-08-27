// ignore_for_file: file_names

import 'package:game_app/constants/index.dart';
import 'package:game_app/models/AccountsForSaleModel.dart';
import 'package:game_app/models/HomePageModel.dart';
import 'package:game_app/views/OtherPages/ShowAllProducts.dart';

import '../../cards/HomePageCard.dart';
import 'Banners.dart';
import 'PubgTypesHomePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<HomePageModel>> futureBanner;
  late Future<List<PubgTypes>> futurePubgType;
  late Future<List<AccountsForSaleModel>> futureLatestProducts;

  @override
  void initState() {
    super.initState();
    futureBanner = HomePageModel().getBanners();
    futurePubgType = PubgTypes().getTypes();
    futureLatestProducts = AccountsForSaleModel().getAccounts(0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kPrimaryColorBlack,
          appBar: const MyAppBar(fontSize: 0, backArrow: false, iconRemove: true, name: "Pubg House", elevationWhite: false),
          body: SingleChildScrollView(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                    width: Get.size.width,
                    child: Banners(
                      future: futureBanner,
                    )),
                namePart("pubgTypes".tr, false),
                PubgTypesHomePage(
                  future: futurePubgType,
                ),
                namePart("accountsForSale".tr, true),
                latestProducts()
              ],
            ),
          )),
    );
  }

  FutureBuilder<List<AccountsForSaleModel>> latestProducts() {
    return FutureBuilder<List<AccountsForSaleModel>>(
        future: futureLatestProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
          } else if (snapshot.hasError) {
            return cannotLoadData();
          } else if (snapshot.data == null) {
            return cannotLoadData();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return HomePageCard(vip: snapshot.data![index].vip ?? false, model: snapshot.data![index]);
            },
          );
        });
  }

  Center cannotLoadData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "errorPubgAccounts".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                AccountsForSaleModel().getAccounts(0);
              },
              style: ElevatedButton.styleFrom(primary: kPrimaryColor),
              child: Text(
                "noConnection3".tr,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium),
              ))
        ],
      ),
    );
  }

  Padding namePart(String text, bool icon) {
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
                    Get.to(() => const ShowAllProducts(
                          name: "accountsForSale",
                          type: 0,
                        ));
                  },
                  icon: const Icon(
                    IconlyLight.arrowRightCircle,
                    color: Colors.white,
                  ))
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
