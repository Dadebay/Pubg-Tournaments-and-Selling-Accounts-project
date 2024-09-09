// ignore_for_file: file_names

import 'package:game_app/models/get_posts_model.dart';
import 'package:game_app/views/constants/dialogs.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:game_app/controllers/show_all_account_controller.dart';
import 'package:game_app/models/home_page_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../cards/show_all_accounts_card.dart';

class ShowAllAccounts extends StatefulWidget {
  final String name;
  const ShowAllAccounts({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  State<ShowAllAccounts> createState() => _ShowAllAccountsState();
}

class _ShowAllAccountsState extends State<ShowAllAccounts> {
  ShowAllAccountsController controller = Get.put(ShowAllAccountsController());
  String name = 'selectCitySubtitle';
  int value = 0;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    controller.clearData();
    value = 0;
  }

  Row leftSideAppBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            defaultBottomSheet(
              name: 'sort'.tr,
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
                      final int a = int.parse(ind.toString());
                      value = a;
                      controller.list.clear();
                      controller.pageNumber.value = 1;
                      controller.sortName.value = sortData[index]['sort_column'];
                      controller.sortType.value = sortData[index]['sort_direction'];
                      GetPostsAccountModel().getPosts(
                        parametrs: {
                          'page': '${controller.pageNumber}',
                          'size': '10',
                          controller.sortName.value: controller.sortType.value,
                          controller.sortCityName.value: controller.sortCityType.value,
                          controller.sortNamePrice.value: controller.sortTypePrice.value,
                          controller.sortNamePriceMax.value: controller.sortTypePriceMax.value,
                        },
                      );
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
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            defaultBottomSheet(
              name: 'Filter'.tr,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  children: [
                    selectCity(),
                    customDivider(),
                    twoTextEditingField(controller1: _controller, controller2: _controller1),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: AgreeButton(
                        name: 'agree',
                        onTap: () {
                          controller.list.clear();
                          controller.pageNumber.value = 1;
                          controller.sortNamePrice.value = 'min';
                          controller.sortTypePrice.value = _controller.text;
                          controller.sortNamePriceMax.value = 'max';
                          controller.sortTypePriceMax.value = _controller1.text;
                          GetPostsAccountModel().getPosts(
                            parametrs: {
                              'page': '${controller.pageNumber}',
                              'size': '10',
                              controller.sortName.value: controller.sortType.value,
                              controller.sortCityName.value: controller.sortCityType.value,
                              controller.sortNamePrice.value: controller.sortTypePrice.value,
                              controller.sortNamePriceMax.value: controller.sortTypePriceMax.value,
                            },
                          );
                          // setState(() {});

                          Get.back();
                        },
                      ),
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
            child: Text('priceRange'.tr, style: const TextStyle(fontFamily: josefinSansSemiBold, fontSize: 19, color: Colors.white)),
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
                      child: Text('TMT', textAlign: TextAlign.center, style: TextStyle(fontFamily: josefinSansSemiBold, fontSize: 14, color: Colors.grey)),
                    ),
                    suffixIconConstraints: const BoxConstraints(minHeight: 15),
                    isDense: true,
                    hintText: 'minPrice'.tr,
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
                    suffixIcon: const Padding(padding: EdgeInsets.only(right: 8), child: Text('TMT', textAlign: TextAlign.center, style: TextStyle(fontFamily: josefinSansSemiBold, fontSize: 14, color: Colors.grey))),
                    suffixIconConstraints: const BoxConstraints(minHeight: 15),
                    isDense: true,
                    hintText: 'maxPrice'.tr,
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

  Padding selectCity() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('selectCityTitle'.tr, style: const TextStyle(color: Colors.grey, fontFamily: josefinSansSemiBold, fontSize: 14)),
            Text(name.tr, style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18)),
          ],
        ),
        leading: const Icon(
          IconlyLight.location,
          size: 30,
        ),
        trailing: const Icon(IconlyLight.arrowRightCircle),
        onTap: () {
          Get.defaultDialog(
            title: 'selectCityTitle'.tr,
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
                    child: Text('Error'),
                  );
                } else if (snapshot.data == null) {
                  return const Center(
                    child: Text('Null'),
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
                            controller.list.clear();
                            controller.pageNumber.value = 1;
                            controller.sortCityName.value = 'city';
                            controller.sortCityType.value = snapshot.data![index].id.toString();
                            name = (Get.locale?.languageCode == 'tr' ? snapshot.data![index].name_tm : snapshot.data![index].name_ru)!;
                            GetPostsAccountModel().getPosts(
                              parametrs: {
                                'page': '${controller.pageNumber}',
                                'size': '10',
                                controller.sortName.value: controller.sortType.value,
                                controller.sortCityName.value: controller.sortCityType.value,
                                controller.sortNamePrice.value: controller.sortTypePrice.value,
                                controller.sortNamePriceMax.value: controller.sortTypePriceMax.value,
                              },
                            );
                            Get.back();
                            Get.back();
                          },
                          child: Text(
                            Get.locale?.languageCode == 'tr' ? snapshot.data![index].name_tm.toString() : snapshot.data![index].name_ru.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    controller.list.clear();
    controller.pageNumber.value = 1;
    controller.clearData();
    value = 0;
    await GetPostsAccountModel().getPosts(parametrs: {'page': '${controller.pageNumber}', 'size': '10'});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      controller.pageNumber.value += 1;
      await GetPostsAccountModel().getPosts(
        parametrs: {
          'page': '${controller.pageNumber}',
          'size': '10',
          controller.sortName.value: controller.sortType.value,
          controller.sortCityName.value: controller.sortCityType.value,
          controller.sortNamePrice.value: controller.sortTypePrice.value,
          controller.sortNamePriceMax.value: controller.sortTypePriceMax.value,
        },
      );
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: MyAppBar(fontSize: 20.0, backArrow: true, iconRemove: false, icon: leftSideAppBar(), name: widget.name.tr, elevationWhite: true),
        body: SmartRefresher(
          footer: footer(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          enablePullDown: true,
          enablePullUp: true,
          physics: const BouncingScrollPhysics(),
          header: const MaterialClassicHeader(
            color: kPrimaryColor,
          ),
          child: FutureBuilder<List<GetPostsAccountModel>>(
            future: GetPostsAccountModel().getVIPPosts(parametrs: {}),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: spinKit());
              } else if (snapshot.hasError) {
                return errorData(onTap: () {});
              } else if (snapshot.data.toString() == '[]') {
                return emptyData();
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: size.width >= 800 ? 3 : 2, mainAxisSpacing: 10, childAspectRatio: size.width >= 800 ? 3 / 4 : 2 / 3, crossAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return ShowAllProductsCard(
                      fav: false,
                      model: snapshot.data![index],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
