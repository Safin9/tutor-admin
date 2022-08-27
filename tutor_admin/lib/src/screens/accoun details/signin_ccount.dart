import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_admin/src/models/user_model.dart';
import 'package:tutor_admin/src/screens/accoun%20details/account_details.dart';
import 'package:tutor_admin/src/tools/login_and_signup_text_fields.dart';

class SignInAccount extends StatelessWidget {
  const SignInAccount({Key? key, required this.user}) : super(key: key);
// FIXME: pass the user here
  final UserModelReady user;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailContr = TextEditingController();
    TextEditingController passContr = TextEditingController();
// FIXME: pass the user email here
    emailContr.text = user.email ?? '';
    ToolsForLogAndSignup tools = ToolsForLogAndSignup();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signin the Account'),
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              text(
                text: 'Name: ${user.name}',
              ),
              text(text: 'email'),
              tools.buildTextField(controller: emailContr, isobsecure: false),
              text(text: 'Password'),
              tools.buildTextField(controller: passContr, isobsecure: false),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: emailContr.text.trim(), password: passContr.text)
                  .then((value) => {
                        Get.offAll(() => AccountDetalis(
                              user: user,
                            ))
                      });
            } catch (e) {
              Get.snackbar('error with signin', e.toString(),
                  backgroundColor: Colors.white);
            }
          },
          label: const Text('Sign in')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget text({required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
