import '../../controllers/wallet_controller.dart';
import '../../models/add_account_model.dart';
import '../../models/home_page_model.dart';
import '../add_page/add_account_page.dart';
import '../constants/dialogs.dart';
import '../constants/index.dart';

FutureBuilder<List<Cities>> getCitiess() {
  return FutureBuilder<List<Cities>>(
    future: Cities().getCities(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: spinKit());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error'));
      } else if (snapshot.data == null) {
        return const Center(child: Text('Empty'));
      }
      return ListView.builder(
        itemCount: snapshot.data!.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              Get.back();
              defaultBottomSheet(name: 'account_type_Vip_or_not', child: getConstss(snapshot.data![index].id!));
            },
            trailing: const Icon(
              IconlyLight.arrowRightCircle,
              color: Colors.white,
            ),
            title: Text(
              Get.locale!.toLanguageTag().toString() == 'tr' ? snapshot.data![index].name_tm.toString() : snapshot.data![index].name_ru.toString(),
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: josefinSansMedium,
                fontSize: 18,
              ),
            ),
          );
        },
      );
    },
  );
}

FutureBuilder<dynamic> getConstss(int locationID) {
  return FutureBuilder<dynamic>(
    future: AddAccountModel().getConsts(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: spinKit());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error'));
      } else if (snapshot.data == null) {
        return const Center(child: Text('Empty'));
      }

      return Wrap(
        children: [
          ListTile(
            onTap: () {
              double b = 0.0;
              double a = 0.0;
              if (snapshot.data!['price_for_vip'].toString() != 'null') {
                b = double.parse(snapshot.data!['price_for_vip']);
              }
              if (Get.find<WalletController>().userMoney.toString() != 'null') {
                a = double.parse(Get.find<WalletController>().userMoney.toString());
              }
              if (a >= b && a != 0.0) {
                Get.back();
                Get.to(
                  () => AddPage(
                    locationID: locationID,
                    vipOrNot: 1,
                  ),
                );
              } else if (b >= a) {
                showSnackBar('money_error_title', 'money_error_subtitle', Colors.red);
              } else {
                showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
              }
            },
            trailing: const Icon(
              IconlyLight.arrowRightCircle,
              color: Colors.white,
            ),
            title: Text(
              'price_for_vip'.tr + " ${snapshot.data!["price_for_vip"]}" + ' TMT',
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: josefinSansMedium,
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              double b = 0.0;
              double a = 0.0;
              b = double.parse(snapshot.data!['price_for_not_vip'].toString());
              a = double.parse(Get.find<WalletController>().userMoney.toString());
              if (a >= b) {
                Get.to(
                  () => AddPage(
                    locationID: locationID,
                    vipOrNot: 0,
                  ),
                );
              } else if (b >= a) {
                showSnackBar('money_error_title', 'money_error_subtitle', Colors.red);
              } else {
                showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
              }
            },
            trailing: const Icon(
              IconlyLight.arrowRightCircle,
              color: Colors.white,
            ),
            title: Text(
              'price_for_not_vip'.tr + " ${snapshot.data!["price_for_not_vip"]}" + ' TMT',
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: josefinSansMedium,
                fontSize: 18,
              ),
            ),
          )
        ],
      );
    },
  );
}
