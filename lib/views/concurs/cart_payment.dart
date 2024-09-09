import 'package:game_app/provider/getkonkur.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:provider/provider.dart';

class CartPayment extends StatefulWidget {
  const CartPayment({
    super.key,
  });

  @override
  State<CartPayment> createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await Provider.of<postPaymentProvider>(context, listen: false).postPayment("1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<postPaymentProvider>(builder: (_, pay, __) {
        if (pay.isLoading == true) {
          return Center(child: spinKit());
        } else {
          return Text("h");
          //  WebView(
          //   initialUrl: pay.payModel?.formUrl,
          //   javascriptMode: JavascriptMode.unrestricted,
          // );
        }
      }),
    );
  }
}
