import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_admin/src/screens/creating%20account/signing_teacher.dart';
import 'package:tutor_admin/src/tools/login_and_signup_text_fields.dart';

class SigningTeacherEmail extends StatefulWidget {
  const SigningTeacherEmail({Key? key}) : super(key: key);

  @override
  State<SigningTeacherEmail> createState() => _SigningTeacherEmailState();
}

class _SigningTeacherEmailState extends State<SigningTeacherEmail> {
  bool isLoading = false;
  ToolsForLogAndSignup tools = ToolsForLogAndSignup();

  TextEditingController emailContr = TextEditingController();
  TextEditingController passwordContr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authenticate'),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    formItem(
                      textField: tools.buildTextField(
                          textInputType: TextInputType.emailAddress,
                          isobsecure: false,
                          controller: emailContr),
                      title: 'Email',
                    ),
                    formItem(
                      textField: tools.buildTextField(
                          isobsecure: false, controller: passwordContr),
                      title: 'Password',
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: emailContr.text.trim(), password: passwordContr.text)
                .then((value) {
              debugPrint('the user is set successfuly$value');
              Get.to(() => const SigningTeacher());
            });
          } catch (e) {
            Get.snackbar('Err from creating account', e.toString());
            setState(() {
              isLoading = true;
            });
          }
        },
      ),
    );
  }

  Widget formItem({
    required Widget textField,
    required String title,
  }) {
    return Container(
      child: Column(
        children: [
          text(text: title),
          textField,
        ],
      ),
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
