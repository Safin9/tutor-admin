import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_admin/src/models/birthdate_model.dart';
import 'package:tutor_admin/src/models/user_model.dart';

import '../first_screen.dart';

class AccountDetalis extends StatelessWidget {
  const AccountDetalis({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModelReady user;
  @override
  Widget build(BuildContext context) {
    final birth = BirthDateModel.fromMap(user.birthDate ?? {'': ''});
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account details'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                wrap(
                    title: 'name:      ', desc: '${user.name} ${user.surname}'),
                const SizedBox(height: 25),
                wrap(title: 'email:     ', desc: user.email ?? 'No email'),
                const SizedBox(height: 25),
                wrap(
                    title: 'phone:     ',
                    desc: user.phoneNumber ?? 'No phone '),
                const SizedBox(height: 25),
                wrap(title: 'age:       ', desc: birth.year.toString()),
                const SizedBox(height: 25),
                wrap(
                    title: 'subject:   ',
                    desc: user.lessonType ?? 'no subject'),
                const SizedBox(height: 25),
                wrap(title: 'joined:    ', desc: user.createdAt),
                const SizedBox(height: 25),
                wrap(title: 'gender:    ', desc: user.gender),
                const SizedBox(height: 25),
                wrap(title: 'city:      ', desc: user.currentCity),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: const Text('candel'),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut().then((value) {
                        Get.off(() => const FirstScreen());
                      });
                    },
                  ),
                  ElevatedButton(
                    child: const Text('delete'),
                    onPressed: () async {
                      await dialog(user: user);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget text({required String text}) {
    return Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          children: [
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ));
  }

  Widget wrap({required String title, required String desc}) {
    return Wrap(
      spacing: 25,
      children: [
        SelectableText(
          title,
          style: bioStyle(),
        ),
        SelectableText(
          desc,
          style: bioStyle(),
        ),
      ],
    );
  }

  TextStyle bioStyle() {
    return const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  }

  Future dialog({required UserModelReady user}) {
    UserModelReady userm = user;

    return Get.dialog(Center(
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 16, 3, 3),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        height: 250,
        width: 250,
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  children: [
                    const Text(
                      'Are you sure to delete:',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userm.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userm.email ?? 'no email',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Cancel',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // FIXME: add a page to show info and delete his account
                        await FirebaseFirestore.instance
                            .collection('Teachers')
                            .doc(user.uid)
                            .delete();
                        await FirebaseAuth.instance.currentUser!
                            .delete()
                            .then((value) {
                          Get.offAll(() => const FirstScreen());
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          textStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      child: const Text(
                        'Delete',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
