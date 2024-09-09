import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/provider/getkonkur.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'concurs_by_id.dart';

class GetConcursScreen extends StatefulWidget {
  const GetConcursScreen({super.key});

  @override
  State<GetConcursScreen> createState() => _GetConcursScreenState();
}

class _GetConcursScreenState extends State<GetConcursScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await Provider.of<getConcursProvider>(context, listen: false).getConcursCart(context);
  }

  final f = new DateFormat('yyyy-MM-dd hh:mm');

  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  String getFormattedDateEnd(String date) {
    var localDate = DateTime.parse(date).toLocal();

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBarNew(
        backArrow: true,
        iconRemove: true,
        elevationWhite: true,
        name: 'Konkurs',
        fontSize: 0.0,
      ),
      body: Consumer<getConcursProvider>(builder: (_, concurs, __) {
        if (concurs.isLoading == true) {
          return Center(child: spinKit());
        } else {
          return ListView.builder(
              itemCount: concurs.concursCart.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConcursByID(id: concurs.concursCart[index].id.toString(), name: concurs.concursCart[index].nameTm)));
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 120,
                              width: 110,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),
                                  child: CachedNetworkImage(
                                    imageUrl: "http://216.250.11.240" + concurs.concursCart[index].image,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ))),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(color: kPrimaryColorBlack, borderRadius: BorderRadius.only(bottomRight: Radius.circular(25))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    getFormattedDate(concurs.concursCart[index].createdDate.toString()),
                                    //  f.format(new DateTime.fromMillisecondsSinceEpoch(concurs.concursCart[index].createdDate * 1000)),

                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  concurs.concursCart[index].nameTm,
                                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: kPrimaryColorBlack, borderRadius: BorderRadius.only(topRight: Radius.circular(25))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    getFormattedDateEnd(concurs.concursCart[index].finishedDate.toString()) + " " + concurs.concursCart[index].finishedTime.toString(),
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      }),
    );
  }
}
