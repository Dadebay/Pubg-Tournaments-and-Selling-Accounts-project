import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tournaments_controller.dart';

class TournamentsView extends GetView<TournamentsController> {
  const TournamentsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TournamentsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TournamentsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
