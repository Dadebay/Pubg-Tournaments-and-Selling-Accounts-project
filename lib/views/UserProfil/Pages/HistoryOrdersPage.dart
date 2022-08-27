// ignore_for_file: file_names

import 'package:game_app/constants/index.dart';
import 'package:game_app/models/HistoryOrderModel.dart';

class HistoryOrdersPage extends StatelessWidget {
  const HistoryOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: const MyAppBar(backArrow: true, fontSize: 0.0, elevationWhite: true, iconRemove: true, name: "History Orders"),
        body: FutureBuilder<List<HistoryOrderModel>>(
            future: HistoryOrderModel().getOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: spinKit());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error"));
              } else if (snapshot.data == null) {
                return const Center(child: Text("Empty"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    title: Text(
                      "Sargyt ${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: josefinSansMedium,
                        fontSize: 18,
                      ),
                    ),
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,
                    childrenPadding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 12),
                    children: const [
                      Text(
                        // Get.locale?.languageCode == "tr" ? snapshot.data![index].content_tm! : snapshot.data![index].content_ru!,
                        "Asd",
                        style: TextStyle(color: Colors.white70, fontSize: 16, fontFamily: josefinSansRegular),
                      )
                    ],
                  );
                },
              );
            }));
  }
}

class OrderByID extends StatelessWidget {
  const OrderByID({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: const MyAppBar(backArrow: true, fontSize: 0.0, elevationWhite: true, iconRemove: true, name: "History Orders"),
        body: FutureBuilder<HistoryOrderModel>(
            future: HistoryOrderModel().getOrderByID(1),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: spinKit());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error"));
              } else if (snapshot.data == null) {
                return const Center(child: Text("Empty"));
              }
              return const Text("Cekdiowww");
            }));
  }
}
