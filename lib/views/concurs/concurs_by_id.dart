import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/uc_models.dart';
import 'package:game_app/models/user_models/auth_model.dart';
import 'package:game_app/provider/getkonkur.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ConcursByID extends StatefulWidget {
  final String id;
  final String name;
  final String price;
  ConcursByID({super.key, required this.id, required this.name, required this.price});

  @override
  State<ConcursByID> createState() => _ConcursByIDState();
}

class _ConcursByIDState extends State<ConcursByID> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await Provider.of<getConcursByIDProvider>(context, listen: false).getConcursCartById(context, widget.id);
  }

  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  String getFormattedDateEnd(String date) {
    var localDate = DateTime.parse(date).toLocal();

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  final WalletController walletController = Get.put(WalletController());

  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: kPrimaryColorBlack,
          appBar: MyAppBarNew(
            backArrow: true,
            iconRemove: false,
            icon: Text(widget.price + " TMT", style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20)),
            elevationWhite: true,
            name: widget.name,
            fontSize: 0.0,
          ),
          body: Consumer<getConcursByIDProvider>(builder: (_, concurs, __) {
            if (concurs.isLoading == true) {
              return Container(margin: const EdgeInsets.all(8), height: 220, width: Get.size.width, decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.4)), child: Center(child: spinKit()));
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    imagePart(context, concurs),
                    PageDate(),
                    Center(
                      child: AgreeButton(
                          onTap: () async {
                            final token = await Auth().getToken();
                            print(token);
                            print(walletController.userMoney.toString());
                            if (token != null && double.parse(walletController.userMoney.toString()) > 0) {
                              settingsController.agreeButton.value = !settingsController.agreeButton.value;
                              final List list = [];
                              for (var element in walletController.cartList) {
                                list.add({'status': "konkurs", 'id': element['id'], 'count': element['count']});
                              }
                              await UcModel().addCart(list).then((value) {
                                if (value == 200 || value == 500) {
                                  walletController.cartList.clear();
                                  walletController.cartList.refresh();
                                  walletController.getUserMoney();
                                  showSnackBar('copySucces', 'orderSubtitle', Colors.green);
                                } else if (value == 404) {
                                  showSnackBar('money_error_title', 'money_error_subtitle', Colors.red);
                                } else {
                                  showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
                                }
                              });
                              settingsController.agreeButton.value = !settingsController.agreeButton.value;
                            } else {
                              print("asdasdasdasdasd");
                              showSnackBar('loginError', 'loginError1', Colors.red);
                            }
                          },
                          name: "tournamentInfo11"),
                    )
                  ],
                ),
              );
            }
          })),
    );
  }

  Expanded PageDate() {
    return Expanded(
        child: Column(
      children: [
        TabBar(
          labelStyle: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold, fontSize: 18),
          unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 17, fontFamily: josefinSansRegular),
          labelColor: kPrimaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: kPrimaryColor,
          indicatorWeight: 4,
          indicatorPadding: const EdgeInsets.only(
            top: 45,
          ),
          indicator: const BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          tabs: [
            Tab(
              text: 'tournamentInfo4'.tr,
            ),
            Tab(
              text: 'tournamentInfo3'.tr,
            ),
          ],
        ),
        Expanded(
            child: TabBarView(children: [
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.amber,
          ),
        ]))
      ],
    ));
  }

  Stack imagePart(BuildContext context, getConcursByIDProvider concurs) {
    Duration duration = concurs.concursCartById!.finishedDate.difference(DateTime.now());

    return Stack(
      children: [
        Container(
            margin: EdgeInsets.only(top: 8),
            height: 200,
            decoration: BoxDecoration(border: Border.all(color: kPrimaryColor, width: 3), borderRadius: borderRadius20),
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
                borderRadius: borderRadius20,
                child: CachedNetworkImage(
                  imageUrl: "http://216.250.11.240${concurs.concursCartById?.image}",
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ))),
        Positioned(
          top: 10,
          left: 2,
          child: Container(
            decoration: BoxDecoration(
                color: kPrimaryColorBlack,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "startDate".tr + getFormattedDate(concurs.concursCartById!.createdDate.toString()),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 2,
          right: 3,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: kPrimaryColorBlack, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
            child: Countdown(
              seconds: duration.inSeconds,
              build: (BuildContext ctx, double time) {
                int days = (time / (24 * 3600)).floor();
                int hours = ((time % (24 * 3600)) / 3600).floor();
                int minutes = ((time % 3600) / 60).floor();
                int seconds = (time % 60).floor();
                String textt = Get.locale!.languageCode == 'tr' ? '$days gün $hours sag $minutes min $seconds s' : '$days день $hours час $minutes мин $seconds s';
                return Text(
                  "endDate".tr + textt,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, fontFamily: josefinSansSemiBold, color: kPrimaryColor),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
