import 'package:game_app/views/constants/index.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OpenOnlinePaymentWebsite extends StatefulWidget {
  const OpenOnlinePaymentWebsite({super.key, required this.url});
  final String url;
  @override
  State<OpenOnlinePaymentWebsite> createState() => _OpenOnlinePaymentWebsiteState();
}

class _OpenOnlinePaymentWebsiteState extends State<OpenOnlinePaymentWebsite> {
  bool isLoading = true;
  late WebViewController _controller;
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
      body: Stack(
        children: [
          WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onPageFinished: (String url) {
                    print(url);
                    print(url);
                    print(url);
                    _controller.runJavaScriptReturningResult("document.body.innerText").then((result) {
                      print("----------------------------------------------------------------------");
                      print(result);
                      // Assuming the JSON data is in the body text
                      // var jsonData = jsonDecode(result);
                      // sendPostRequest(jsonData);
                    });
                  },
                ),
              )
              ..loadRequest(Uri.parse(widget.url)),
          ),
          // WebView(
          //   javascriptMode: JavascriptMode.unrestricted,
          //   initialUrl: widget.url,
          //   navigationDelegate: (request) {
          //     print(request.url);
          //     if (request.url.contains('connect-success')) {
          //       // TODO when api success
          //     } else if (request.url.contains('connect-fail')) {
          //       // TODO when api fail
          //     }
          //     return NavigationDecision.navigate;
          //   },
          //   onPageStarted: (String url) {
          //     setState(() {
          //       isLoading = true;
          //     });
          //   },
          //   onPageFinished: (String url) {
          //     setState(() {
          //       isLoading = false;
          //     });
          //   },
          // ),
          isLoading
              ? Positioned.fill(
                  child: Container(color: kPrimaryColorBlack.withOpacity(0.8), child: spinKit()),
                )
              : Container(),
        ],
      ),
    );
  }
}
