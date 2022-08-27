import 'package:flutter/cupertino.dart';
import 'package:tutor_admin/src/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModelReady? theUser;
  setUser(UserModelReady user) {
    theUser = user;
    debugPrint('from provider : $theUser');
    notifyListeners();
  }
}
