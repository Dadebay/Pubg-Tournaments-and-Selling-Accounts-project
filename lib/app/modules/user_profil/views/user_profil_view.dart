import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_profil_controller.dart';

class UserProfilView extends GetView<UserProfilController> {
  const UserProfilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserProfilView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UserProfilView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
