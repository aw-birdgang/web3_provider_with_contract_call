import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../common/string_util.dart';
import '../models/user_model.dart';
import '../shared/helper/prefer_helper.dart';

class AuthController extends ChangeNotifier {
  bool isloadingSignIn = false;
  String errorMessage = "";

  UserModel? currentuserModel;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthController() {
    getUserModel();
  }

  getUserModel() async {
    String userId = await PreferHelper.getUserId();
    if (isNotExistsStr(userId)) {
      currentuserModel = null;
      return null;
    }

    String email = await PreferHelper.getEmail();
    String password = await PreferHelper.getPassword();
    return signIn(email, password,);
  }

  Future<UserModel?> signIn(String email, String password) async {
    print("email : " + email + " , password : " + password);
    UserModel? userModel;
    isloadingSignIn = true;
    notifyListeners();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      userModel = UserModel(
        email: userCredential.user?.email,
        name: userCredential.user?.displayName,
        pic: '',
        userId: userCredential.user?.uid
      );
      isloadingSignIn = false;
      currentuserModel = userModel;
      notifyListeners();
    } catch (e) {
      isloadingSignIn = false;
      errorMessage = e.toString();
      notifyListeners();
      print(e.toString());
    }
    return currentuserModel;
  }

  bool showPassword = false;
  onChangePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  bool isShowPassword () {
    return (showPassword) ? false : true;
  }

  Future SignOut() async {
    await FirebaseAuth.instance.signOut();
    currentuserModel = null;
    PreferHelper.setUserId("");
    PreferHelper.setEmail("");
    PreferHelper.setPassword("");
    notifyListeners();
  }
}
