// ignore_for_file: always_declare_return_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/views/concurs/get_concurs.dart';
import 'package:game_app/views/concurs/get_gifts.dart';
import 'package:game_app/views/concurs/other_konkurs.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:provider/provider.dart';

import '../../provider/getkonkur.dart';

class KonkursScreen extends StatefulWidget {
  const KonkursScreen({super.key});

  @override
  State<KonkursScreen> createState() => _KonkursScreenState();
}

class _KonkursScreenState extends State<KonkursScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await Provider.of<ConCatigoryProvider>(context, listen: false).getConCatigory(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBarNew(
        fontSize: 0,
        backArrow: false,
        iconRemove: false,
        name: 'Gifts & Konkurs',
        elevationWhite: true,
      ),
      body: Consumer<ConCatigoryProvider>(
        builder: (_, concurs, __) {
          if (concurs.isLoading == true) {
            return Center(child: spinKit());
          } else {
            return ListView.builder(
              itemCount: concurs.conCatigory.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      if (index == 0) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GetConcursScreen()));
                      } else if (index == 1) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GetGiftsScreen()));
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OtherConcursScreen(
                              pageName: concurs.conCatigory[index].nameTm,
                              sellingID: concurs.conCatigory[index].id,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColorBlack1,
                        borderRadius: borderRadius15,
                        border: Border.all(color: kPrimaryColor.withOpacity(0.4)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),
                              child: CachedNetworkImage(
                                imageUrl: 'http://216.250.11.240${concurs.conCatigory[index].image}',
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, downloadProgress) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              concurs.conCatigory[index].nameTm,
                              style: const TextStyle(fontSize: 24, fontFamily: josefinSansBold, color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
