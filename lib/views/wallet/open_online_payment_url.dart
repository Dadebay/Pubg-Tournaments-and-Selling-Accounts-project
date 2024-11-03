import 'dart:convert';
import 'dart:io';

import 'package:game_app/bottom_nav_bar.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/user_models/auth_model.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class OpenOnlinePaymentWebsite extends StatefulWidget {
  const OpenOnlinePaymentWebsite({required this.url, required this.list, super.key});
  final String url;
  final List list;
  @override
  State<OpenOnlinePaymentWebsite> createState() => _OpenOnlinePaymentWebsiteState();
}

class _OpenOnlinePaymentWebsiteState extends State<OpenOnlinePaymentWebsite> {
  late WebViewController _controller;
  final WalletController walletController = Get.put(WalletController());

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            print(url);
            _controller.runJavaScriptReturningResult('document.body.innerText').then((result) async {
              print('----------------------------------------------------------------------');
              print(result);

              // Assuming the JSON data is in the body text
              try {
                // Log the type of result to understand its structure
                print('Result type: ${result.runtimeType}');
                print('Result: $result');

                // Attempt to decode the JSON
                final jsonData = jsonDecode(result.toString());
                print('Decoded JSON: $jsonData');

                // Extract orderId from the URL
                final Uri uri = Uri.parse(url);
                final String? orderId = uri.queryParameters['orderId'];
                print('Order ID from URL: $orderId');

                if (orderId != null) {
                  final String? token = await Auth().getToken();

                  // Add orderId to each item in widget.list
                  final List listTest = widget.list
                      .map(
                        (e) => {
                          'status': e['status'],
                          'id': e['id'],
                          'count': e['count'],
                          'orderId': orderId,
                          'pubg_id': e['pubg_id'],
                        },
                      )
                      .toList();

                  final response2 = await http.post(
                    Uri.parse('$serverURL/api/category/paymentStatus/'),
                    headers: <String, String>{
                      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
                      HttpHeaders.authorizationHeader: 'Bearer $token',
                    },
                    body: jsonEncode(listTest),
                  );

                  print('______________________________________________________________________________________________???????????????????????????');
                  print(listTest);
                  print(response2.body);
                  print(response2.statusCode);
                  print('______________________________________________________________________________________________???????????????????????????');
                  if (response2.statusCode == 200) {
                    walletController.cartList.clear();
                    walletController.cartList.refresh();
                    showSnackBar('copySucces', 'orderSubtitle', Colors.green);
                    Get.to(() => const BottomNavBar());
                  }
                  return response2.statusCode;
                } else {
                  print('Order ID not found in URL.');
                }
              } catch (e) {
                print('Error parsing JSON: $e');
              }
            });
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        fontSize: 0.0,
        backArrow: true,
        icon: userAppBarMoney(),
        iconRemove: false,
        name: 'orderPage'.tr,
        elevationWhite: true,
      ),
      backgroundColor: kPrimaryColorBlack,
      body: WebViewWidget(
        controller: _controller..loadRequest(Uri.parse(widget.url)),
      ),
    );
  }
}
