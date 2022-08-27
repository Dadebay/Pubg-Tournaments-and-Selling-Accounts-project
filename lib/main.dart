// ignore_for_file: prefer_const_constructors

import 'package:game_app/constants/index.dart';

import 'connection_check.dart';
import 'controllers/AllContollerBindings.dart';
import 'utils/translations.dart';

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: kPrimaryColorBlack,
    statusBarColor: kPrimaryColorBlack,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyAppRun());
}

class MyAppRun extends StatefulWidget {
  const MyAppRun({Key? key}) : super(key: key);

  @override
  State<MyAppRun> createState() => _MyAppRunState();
}

class _MyAppRunState extends State<MyAppRun> {
  final storage = GetStorage();

  // final WalletController controller = Get.put(WalletController());
  @override
  void initState() {
    super.initState();
    // controller.returnCartList();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AllControllerBindings(),
      defaultTransition: Transition.fade,
      locale: storage.read('langCode') != null
          ? Locale(storage.read('langCode'))
          : const Locale(
              'tr',
            ),

      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: josefinSansRegular,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      fallbackLocale: const Locale("tr"),
      translations: MyTranslations(),
      debugShowCheckedModeBanner: false,
      home: ConnectionCheck(),
      // home: BottomNavBar(),
    );
  }
}
