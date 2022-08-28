import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_admin/src/models/user_model.dart';

class StudentView extends StatefulWidget {
  const StudentView({Key? key}) : super(key: key);

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students',
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection('Users').snapshots(),
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
                        final theUser = snapshot.data!.docs[index];
                        final user = UserModelReady.fromSnapShot(theUser);
                        return ListTile(
                          onTap: () {
                            print(user.uid + user.name);
                          },
                          subtitle: Text(index.toString()),
                          title: Text(user.name),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              dialog(user: theUser);
                            },
                          ),
                        );
                      }),
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          thickness: 1,
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

  Future dialog({required QueryDocumentSnapshot<Map<String, dynamic>> user}) {
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
                  children: const [
                    Text(
                      'Are you sure to delete:',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'here\'s Location Screens/Student_view.dart at the bottom (dialog)',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   user['email'],
                    //   style: const TextStyle(
                    //       fontSize: 13, fontWeight: FontWeight.normal),
                    // ),
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
                        await user.reference.delete();
                        Get.back();
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
