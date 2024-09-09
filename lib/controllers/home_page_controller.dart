import 'package:game_app/views/constants/index.dart';

import '../models/accouts_for_sale_model.dart';
import '../models/home_page_model.dart';

class HomePageController extends GetxController {
  late Future<List<BannerModel>> futureBanner;
  List<AccountsForSaleModel> list = [];
  RxInt pageNumber = 1.obs;
  RxInt loading = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }
}
