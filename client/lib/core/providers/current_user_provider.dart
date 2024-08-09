import 'dart:developer';

import 'package:client/core/enums/gender.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';

class CurrentUserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    name: "",
    email: "",
    password: "",
    birthday: "",
    gender: Gender.male,
  );

  UserModel get user => _user;

  void addUser(UserModel user) {
    log(user.toString());
    Future.microtask(() {
      _user = user;
      notifyListeners();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      log("User is: ${_user.toString()}");
    });
  }
}
