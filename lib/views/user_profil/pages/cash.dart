// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_app/constants/app_bar.dart';
import 'package:game_app/constants/constants.dart';

class MyCash extends StatelessWidget {
  const MyCash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(backArrow: true, fontSize: 0.0, iconRemove: false, elevationWhite: true, name: "bal"),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {}, child: const Text("Odeme Yap")),
          ElevatedButton(onPressed: () {}, child: const Text("Odeme tarihleri")),
          ElevatedButton(onPressed: () {}, child: const Text("Bal cekme")),
        ],
      ),
    );
  }
}
