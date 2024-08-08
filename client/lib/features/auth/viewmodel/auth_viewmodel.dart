import 'package:client/core/router/route_paths.dart';
import 'package:client/core/utils/toast_utils.dart';
import 'package:client/di.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:flutter/material.dart';
import 'package:client/core/enums/gender.dart';
import 'package:go_router/go_router.dart';

class AuthViewModel extends ChangeNotifier {
  final authRemoteRepository = getIt<AuthRemoteRepository>();
  UserModel _userModel = UserModel(
    name: "",
    email: "",
    password: "",
    birthday: "",
    gender: Gender.male,
  );
  final PageController _pageController = PageController();
  int currentPage = 0;
  bool _isLoading = false;

  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  PageController get pageController => _pageController;

  void updateLoading(bool val) {
    Future.microtask(() {
      _isLoading = val;
      notifyListeners();
    });
  }

  void updateEmail(String email) {
    _userModel = _userModel.copyWith(email: email);
    notifyListeners();
  }

  void updatePassword(String password) {
    _userModel = _userModel.copyWith(password: password);
    notifyListeners();
  }

  void updateBirthday(String birthday) {
    _userModel = _userModel.copyWith(birthday: birthday);
    notifyListeners();
  }

  void updateGender(Gender gender) {
    _userModel = _userModel.copyWith(gender: gender);
    notifyListeners();
  }

  void updateName(String name) {
    _userModel = _userModel.copyWith(name: name);
    notifyListeners();
  }

  Future<void> signup({required BuildContext context}) async {
    updateLoading(true);
    final res = await authRemoteRepository.signup(
      user: UserModel(
        name: _userModel.name,
        email: _userModel.email,
        password: _userModel.password,
        birthday: _userModel.birthday,
        gender: _userModel.gender,
      ),
    );
    res.fold((l) {
      updateLoading(true);
      ToastUtils.showError(context, l.message);
    }, (r) {
      updateLoading(false);
      context.pushNamed(RoutePaths.navScreen);
      return null;
    });
    updateLoading(false);
  }

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    updateLoading(true);
    final res = await authRemoteRepository.login(
      password: password,
      email: email,
    );
    res.fold((l) {
      updateLoading(true);
      ToastUtils.showError(context, l.message);
    }, (r) {
      updateLoading(false);
      context.pushNamed(RoutePaths.navScreen);
      return null;
    });
    updateLoading(false);
  }

  void clear() {
    _userModel = UserModel(
      name: "",
      email: "",
      password: "",
      birthday: "",
      gender: Gender.male,
    );

    notifyListeners();
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    currentPage++;
    notifyListeners();
  }

  void previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    currentPage--;
    notifyListeners();
  }
}
