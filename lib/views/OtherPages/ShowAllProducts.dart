// ignore_for_file: file_names

import 'package:game_app/cards/ShowAllProductsCard.dart';
import 'package:game_app/constants/dialogs.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/FilterController.dart';
import 'package:game_app/models/AccountsForSaleModel.dart';
import 'package:game_app/models/HomePageModel.dart';

class ShowAllProducts extends StatefulWidget {
  final String name;
  final int type;
  const ShowAllProducts({Key? key, required this.name, required this.type}) : super(key: key);

  @override
  State<ShowAllProducts> createState() => _ShowAllProductsState();
}

class _ShowAllProductsState extends State<ShowAllProducts> {
  @override
  void initState() {
    super.initState();
    Get.find<FilterController>().sortName.value = "";
    Get.find<FilterController>().sortType.value = "";
    Get.find<FilterController>().sortName1.value = "";
    Get.find<FilterController>().sortType1.value = "";
    Get.find<FilterController>().sortTypePrice.value = "";
    Get.find<FilterController>().sortNamePrice.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: MyAppBar(fontSize: 20.0, backArrow: true, iconRemove: false, icon: leftSideAppBar(), name: widget.name.tr, elevationWhite: true),
        body: FutureBuilder<List<AccountsForSaleModel>>(
            future: AccountsForSaleModel().getAccounts(widget.type),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: spinKit());
              } else if (snapshot.hasError) {
                return const Text("Empty");
              } else if (snapshot.data == null) {
                return const Text("Error");
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 15, childAspectRatio: 2 / 3, crossAxisSpacing: 15),
                    itemBuilder: (BuildContext context, int index) {
                      return ShowAllProductsCard(
                        fav: false,
                        model: snapshot.data![index],
                      );
                    }),
              );
            }),
      ),
    );
  }

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();

  Row leftSideAppBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () {
              defaultBottomSheet(
                name: "sort".tr,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: sortData.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      value: index,
                      tileColor: kPrimaryColorBlack,
                      selectedTileColor: kPrimaryColorBlack,
                      activeColor: kPrimaryColor,
                      groupValue: value,
                      onChanged: (ind) {
                        setState(() {
                          int a = int.parse(ind.toString());
                          value = a;
                          Get.find<FilterController>().sortName.value = sortData[index]["sort_column"];
                          Get.find<FilterController>().sortType.value = sortData[index]["sort_direction"];
                          AccountsForSaleModel().getAccounts(widget.type);
                        });
                        Get.back();
                      },
                      title: Text(
                        "${sortData[index]["name"]}".tr,
                        style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium),
                      ),
                    );
                  },
                ),
              );
            },
            icon: const Icon(
              IconlyLight.filter,
              color: Colors.white,
            )),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            defaultBottomSheet(
              name: "Filter".tr,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  children: [
                    selectCity(),
                    customDivider(),
                    twoTextEditingField(controller1: _controller, controller2: _controller1),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: AgreeButton(onTap: () {
                        Get.find<FilterController>().sortNamePrice.value = "min=${_controller.text}";
                        Get.find<FilterController>().sortTypePrice.value = "max=${_controller1.text}";
                        AccountsForSaleModel().getAccounts(widget.type);
                        setState(() {});
                        Get.back();
                      }),
                    ),
                  ],
                ),
              ),
            );
          },
          child: const Icon(
            IconlyLight.filter2,
            color: Colors.white,
            size: 30,
          ),
        ),
      ],
    );
  }

  Widget twoTextEditingField({required TextEditingController controller1, required TextEditingController controller2}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 20),
            child: Text("priceRange".tr, style: const TextStyle(fontFamily: josefinSansSemiBold, fontSize: 19, color: Colors.white)),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontFamily: josefinSansMedium, fontSize: 18),
                  cursorColor: kPrimaryColor,
                  controller: controller1,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text("TMT", textAlign: TextAlign.center, style: TextStyle(fontFamily: josefinSansSemiBold, fontSize: 14, color: Colors.grey)),
                    ),
                    suffixIconConstraints: const BoxConstraints(minHeight: 15),
                    isDense: true,
                    hintText: "minPrice".tr,
                    hintStyle: const TextStyle(fontFamily: josefinSansMedium, fontSize: 16, color: Colors.white),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                    ),
                  ),
                ),
              ),
              Container(
                width: 15,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 2,
                color: Colors.grey,
              ),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontFamily: josefinSansMedium, fontSize: 18),
                  cursorColor: kPrimaryColor,
                  controller: controller2,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // LengthLimitingTextInputFormatter(9),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: const Padding(padding: EdgeInsets.only(right: 8), child: Text("TMT", textAlign: TextAlign.center, style: TextStyle(fontFamily: josefinSansSemiBold, fontSize: 14, color: Colors.grey))),
                    suffixIconConstraints: const BoxConstraints(minHeight: 15),
                    isDense: true,
                    hintText: "maxPrice".tr,
                    hintStyle: const TextStyle(fontFamily: josefinSansMedium, fontSize: 16, color: Colors.white),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding customListTile({required String title, required String subtitle, required Function() onTap, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title.tr, style: const TextStyle(color: Colors.grey, fontFamily: josefinSansSemiBold, fontSize: 14)),
            Text(subtitle.tr, style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18)),
          ],
        ),
        leading: Icon(
          icon,
          size: 30,
        ),
        trailing: const Icon(IconlyLight.arrowRightCircle),
        onTap: onTap,
      ),
    );
  }

  String name = "selectCitySubtitle";
  Padding selectCity() {
    return customListTile(
      subtitle: name,
      title: 'selectCityTitle',
      icon: IconlyLight.location,
      onTap: () {
        Get.defaultDialog(
            title: "selectCityTitle".tr,
            titleStyle: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
            radius: 5,
            backgroundColor: kPrimaryColorBlack,
            titlePadding: const EdgeInsets.symmetric(vertical: 20),
            contentPadding: const EdgeInsets.only(),
            content: FutureBuilder<List<Cities>>(
                future: Cities().getCities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: spinKit());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text("Null"),
                    );
                  }
                  return Column(
                    children: List.generate(
                        snapshot.data!.length,
                        (index) => Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              children: [
                                customDivider(),
                                TextButton(
                                  onPressed: () {
                                    Get.find<FilterController>().sortName1.value = "city";
                                    Get.find<FilterController>().sortType1.value = snapshot.data![index].id.toString();
                                    name = (Get.locale?.languageCode == "tr" ? snapshot.data![index].name_tm : snapshot.data![index].name_ru)!;
                                    AccountsForSaleModel().getAccounts(widget.type);
                                    setState(() {});
                                    Get.back();
                                    Get.back();
                                  },
                                  child: Text(
                                    Get.locale?.languageCode == "tr" ? snapshot.data![index].name_tm.toString() : snapshot.data![index].name_ru.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
                                  ),
                                ),
                              ],
                            )),
                  );
                }));
      },
    );
  }

  List sortData = [
    {
      "id": 1,
      "name": "sortDefault",
      "sort_column": "price",
      "sort_direction": "",
    },
    {
      "id": 2,
      "name": "sortPriceLowToHigh",
      "sort_column": "price",
      "sort_direction": "high",
    },
    {
      "id": 3,
      "name": "sortPriceHighToLow",
      "sort_column": "price",
      "sort_direction": "low",
    },
    {
      "id": 4,
      "name": "sortCreatedAtHighToLow",
      "sort_column": "date",
      "sort_direction": "new",
    },
    {
      "id": 5,
      "name": "sortCreatedAtLowToHigh",
      "sort_column": "date",
      "sort_direction": "old",
    },
  ];

  int value = 0;
}
