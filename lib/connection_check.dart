// ignore_for_file: file_names, avoid_positional_boolean_parameters, avoid_void_async, always_declare_return_types, always_use_package_imports

import 'dart:io';
import 'package:game_app/BottomNavBar.dart';
import 'package:game_app/constants/index.dart';
import 'package:lottie/lottie.dart';

class ConnectionCheck extends StatefulWidget {
  const ConnectionCheck({Key? key}) : super(key: key);

  @override
  _ConnectionCheckState createState() => _ConnectionCheckState();
}

class _ConnectionCheckState extends State<ConnectionCheck> {
  String firsttime = "false";
  String token = "false";

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  void checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
            return const BottomNavBar();
          }));
        });
      }
    } on SocketException catch (_) {
      _showDialog();
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              shape: const RoundedRectangleBorder(borderRadius: borderRadius20),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      padding: const EdgeInsets.only(top: 100),
                      decoration: const BoxDecoration(color: Colors.white, borderRadius: borderRadius20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'noConnection1'.tr,
                            style: const TextStyle(
                              fontSize: 24.0,
                              color: kPrimaryColor,
                              fontFamily: josefinSansMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            child: Text(
                              'noConnection2'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: josefinSansMedium,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            color: kPrimaryColor,
                            shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Future.delayed(const Duration(milliseconds: 1000), () {
                                checkConnection();
                              });
                            },
                            child: Text(
                              "noConnection3".tr,
                              style: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: josefinSansMedium),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 70,
                      minRadius: 60,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          child: Image.asset(
                            "assets/icons/noconnection.gif",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      body: Stack(
        children: [
          Positioned.fill(child: Center(child: Lottie.asset("assets/lottie/pubg.json", height: 400, width: 400, fit: BoxFit.cover))),
        ],
      ),
    );
  }
}