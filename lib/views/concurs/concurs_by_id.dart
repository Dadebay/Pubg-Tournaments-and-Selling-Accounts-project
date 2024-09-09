import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/provider/getkonkur.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConcursByID extends StatefulWidget {
  final String id;
  final String name;
  ConcursByID({super.key, required this.id, required this.name});

  @override
  State<ConcursByID> createState() => _ConcursByIDState();
}

class _ConcursByIDState extends State<ConcursByID> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await Provider.of<getConcursByIDProvider>(context, listen: false).getConcursCartById(context, widget.id);
  }

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
        appBar: MyAppBarNew(
          backArrow: true,
          iconRemove: true,
          elevationWhite: true,
          name: widget.name,
          fontSize: 0.0,
        ),
        body: Consumer<getConcursByIDProvider>(builder: (_, concurs, __) {
          if (concurs.isLoading == true) {
            return Container(margin: const EdgeInsets.all(8), height: 220, width: Get.size.width, decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.4)), child: Center(child: spinKit()));
          } else {
            return Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),
                            child: CachedNetworkImage(
                              imageUrl: "http://216.250.11.240${concurs.concursCartById?.image}",
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: kPrimaryColorBlack, borderRadius: BorderRadius.only(bottomRight: Radius.circular(25))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              getFormattedDate(concurs.concursCartById?.createdDate.toString() ?? ""),
                              //  f.format(new DateTime.fromMillisecondsSinceEpoch(concurs.concursCart[index].createdDate * 1000)),

                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10),
                        //   child: Text(
                        //     concurs.concursCartById?.nameTm ?? "",
                        //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        Container(
                          decoration: BoxDecoration(color: kPrimaryColorBlack, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  getFormattedDateEnd(concurs.concursCartById?.finishedDate.toString() ?? "") + " ",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  concurs.concursCartById?.finishedTime.toString() ?? "",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            );
          }
        }));
  }
}
