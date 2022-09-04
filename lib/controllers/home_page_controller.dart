import 'package:game_app/constants/index.dart';
import 'package:game_app/models/index_model.dart';

class HomePageController extends GetxController {
  late Future<List<BannerModel>> futureBanner;
  late Future<List<PubgTypesModel>> futurePubgType;
  List<AccountsForSaleModel> list = [];
  RxInt pageNumber = 1.obs;
  RxInt loading = 0.obs;
  @override
  void onInit() {
    super.onInit();
    futureBanner = BannerModel().getBanners();
    futurePubgType = PubgTypesModel().getTypes();
  }
}
