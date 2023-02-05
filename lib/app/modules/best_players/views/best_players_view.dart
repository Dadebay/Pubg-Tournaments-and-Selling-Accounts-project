import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/best_players_controller.dart';

class BestPlayersView extends GetView<BestPlayersController> {
  const BestPlayersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BestPlayersView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BestPlayersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
