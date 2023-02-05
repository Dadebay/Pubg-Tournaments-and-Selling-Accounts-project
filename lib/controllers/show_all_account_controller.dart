// ignore_for_file: file_names

import 'package:get/state_manager.dart';

import '../models/accouts_for_sale_model.dart';

class ShowAllAccountsController extends GetxController {
  RxString sortType = ''.obs;
  RxString sortName = ''.obs;
  RxString sortCityType = ''.obs;
  RxString sortCityName = ''.obs;
  RxString sortTypePrice = ''.obs;
  RxString sortNamePrice = ''.obs;
  RxString sortTypePriceMax = ''.obs;
  RxString sortNamePriceMax = ''.obs;
  List<AccountsForSaleModel> list = [];
  RxInt pageNumber = 1.obs;
  RxInt loading = 0.obs;

  dynamic clearData() {
    sortName.value = '';
    sortType.value = '';
    sortCityName.value = '';
    sortCityType.value = '';
    sortTypePrice.value = '';
    sortNamePrice.value = '';
    sortTypePriceMax.value = '';
    sortNamePriceMax.value = '';
    list.clear();
    pageNumber.value = 1;
  }
}
