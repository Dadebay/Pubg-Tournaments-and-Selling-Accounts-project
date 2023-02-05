import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pubg_uc_controller.dart';

class PubgUcView extends GetView<PubgUcController> {
  const PubgUcView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PubgUcView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PubgUcView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
