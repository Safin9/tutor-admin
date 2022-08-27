import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  creatAccount({required String email, required String password}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.snackbar('success', 'Successfuly created');
      });
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }
}
