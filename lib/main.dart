// ignore_for_file: prefer_const_constructors
import 'package:game_app/app/constants/others/main_helper.dart';
import 'package:game_app/app/constants/utils/translations.dart';
import 'package:get/get.dart';

import 'app/constants/packages/index.dart';

Future<void> main() async {
  mainDartImports();
  await Firebase.initializeApp();

  runApp(const MyAppRun());
}

class MyAppRun extends StatefulWidget {
  const MyAppRun({Key? key}) : super(key: key);
  @override
  State<MyAppRun> createState() => _MyAppRunState();
}

class _MyAppRunState extends State<MyAppRun> {
  final storage = GetStorage();
  @override
  void initState() {
    super.initState();
    myAppOnInit();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      theme: ThemeData(brightness: Brightness.dark, fontFamily: josefinSansRegular, useMaterial3: true, visualDensity: VisualDensity.adaptivePlatformDensity, appBarTheme: AppBarTheme(elevation: 0, backgroundColor: kPrimaryColorBlack)),
      fallbackLocale: const Locale('tr'),
      translations: MyTranslations(),
      debugShowCheckedModeBanner: false,
      home: ConnectionCheck(),
    );
  }
}
