import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_admin/src/models/user_model.dart';
import 'package:tutor_admin/src/screens/accoun%20details/signin_ccount.dart';
import 'package:tutor_admin/src/screens/creating%20account/signing_teacher_email.dart';

class TeachersView extends StatefulWidget {
  const TeachersView({Key? key}) : super(key: key);

  @override
  State<TeachersView> createState() => _TeachersViewState();
}

class _TeachersViewState extends State<TeachersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Teachers',
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const SigningTeacherEmail()),
            icon: const Icon(
              Icons.add,
              // color: Colors.black,
            ),
          )
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Teachers')
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(child: Text('No data to show'));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return const Center(
                      child: Text('Connected'),
                    );
                  }

                  return Scrollbar(
                    child: ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        final user = snapshot.data!.docs[index];

                        return ListTile(
                          onTap: () {
                            final u = user.data()['uid'];
                            Get.to(() => SignInAccount(
                                user: UserModelReady.fromSnapShot(user)));
                            print('data of tapped user :  $u');
                          },
                          title: Text(user['name']),
                          subtitle: Text(user['email']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // dialog(user: user);
                            },
                          ),
                        );
                      }),
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
