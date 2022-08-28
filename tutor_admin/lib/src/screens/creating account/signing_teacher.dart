import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tutor_admin/src/models/birthdate_model.dart';
import 'package:tutor_admin/src/models/user_model.dart';
import 'package:tutor_admin/src/providers/user_provider.dart';
import 'package:tutor_admin/src/screens/first_screen.dart';
import 'package:tutor_admin/src/tools/general_dropdown.dart';
import 'package:tutor_admin/src/tools/login_and_signup_text_fields.dart';
import 'package:tutor_admin/src/tools/strings.dart';
import 'package:intl/intl.dart';

class SigningTeacher extends StatefulWidget {
  const SigningTeacher({Key? key}) : super(key: key);

  @override
  State<SigningTeacher> createState() => _SigningTeacherState();
}

class _SigningTeacherState extends State<SigningTeacher> {
  ToolsForLogAndSignup? tools;
  TextEditingController? emailContr;
  TextEditingController? passwordContr;
  TextEditingController? shortBioContr;
  TextEditingController? languages;
  TextEditingController? educationContr;
  TextEditingController? nameContr;
  TextEditingController? surnameContr;
  TextEditingController? phoneContr;

  final signUpFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  bool isLoading = false;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  RequiredStrings strs = RequiredStrings();
  String? downloadUrl;
  String selectedDay = '0';
  String selectedMonth = '0';
  String selectedYear = '0';

  String? selectedCity = 'Duhok';
  String? selectedGender = 'Male';
  String? selectedLessonType = 'Not Defined';
  DateTime? birthDate;
  @override
  void initState() {
    strs.methodForInts();
    tools = ToolsForLogAndSignup();
    emailContr = TextEditingController();
    shortBioContr = TextEditingController();
    passwordContr = TextEditingController();
    nameContr = TextEditingController();
    languages = TextEditingController();
    educationContr = TextEditingController();
    surnameContr = TextEditingController();
    phoneContr = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailContr!.dispose();
    nameContr!.dispose();
    surnameContr!.dispose();
    passwordContr!.dispose();
    phoneContr!.dispose();
    shortBioContr!.dispose();
    languages!.dispose();
    educationContr!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Signing a teacher',
        ),
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
                      textField: tools!.buildTextField(
                          isobsecure: false, controller: nameContr),
                      title: 'Name',
                    ),
                    formItem(
                      textField: tools!.buildTextField(
                          isobsecure: false, controller: surnameContr),
                      title: 'Surname',
                    ),
                    formItem(
                      textField: tools!.buildTextField(
                          isobsecure: false, controller: phoneContr),
                      title: 'Phone Number',
                    ),
                    formItem(
                      textField: tools!.buildTextField(
                          isobsecure: false, controller: shortBioContr),
                      title: 'Short bio',
                    ),
                    formItem(
                      textField: tools!.buildTextField(
                          isobsecure: false, controller: languages),
                      title: 'Languages',
                    ),
                    formItem(
                      textField: tools!.buildTextField(
                          isobsecure: false, controller: educationContr),
                      title: 'Education Degree',
                    ),
                    text(text: 'Birth Date'),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          datePicker(
                              items: strs.days,
                              sizeWidth: size.width,
                              valueChanged: (value) {
                                setState(() {
                                  selectedDay = value;
                                });
                              }),
                          datePicker(
                              items: strs.months,
                              sizeWidth: size.width,
                              valueChanged: (value) {
                                setState(() {
                                  selectedMonth = value;
                                });
                              }),
                          datePicker(
                              items: strs.years,
                              sizeWidth: size.width,
                              valueChanged: (value) {
                                setState(() {
                                  selectedYear = value;
                                });
                              }),
                        ],
                      ),
                    ),
                    text(text: 'Subject'),
                    GeneralDropDownButton(
                        itemsList: strs.lessonType,
                        valueChanged: ((value) {
                          setState(() {
                            selectedLessonType = value;
                          });
                        })),
                    text(text: 'City'),
                    GeneralDropDownButton(
                        itemsList: strs.citysList,
                        valueChanged: ((value) {
                          setState(() {
                            selectedCity = value;
                          });
                        })),
                    const SizedBox(height: 10),
                    text(text: 'Gender'),
                    GeneralDropDownButton(
                        itemsList: strs.gender,
                        valueChanged: ((value) {
                          setState(() {
                            selectedGender = value;
                          });
                        })),
                    const SizedBox(height: 50),
                    _selectedImage == null
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width - 50,
                            child: text(text: 'Select image'),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.width * 0.5,
                            child: Image.file(File(_selectedImage!.path)),
                          ),
                    SizedBox(
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () async {
                              XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                _selectedImage = image;
                              });
                            },
                            child: const Text('pick Image'))),
                    downloadUrl == null
                        ? Container()
                        : SelectableText(downloadUrl!),
                    const SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DateTime now = DateTime.now();

          final formatter = DateFormat('yyyy-MM-dd');
          final String formatted = formatter.format(now);
          BirthDateModel birthDate = BirthDateModel(
              year: int.parse(selectedYear),
              month: int.parse(selectedMonth),
              day: int.parse(selectedDay));
          UserModelReady user = UserModelReady(
            currentCity: selectedCity.toString(),
            email: FirebaseAuth.instance.currentUser!.email,
            gender: selectedGender.toString(),
            imageUrl: _selectedImage == null ? '' : _selectedImage!.path,
            lessonType: selectedLessonType,
            languages: [languages!.text],
            shortbio: shortBioContr!.text.trim(),
            name: nameContr!.text,
            tacherOrStudent: 'Teacher',
            birthDate: birthDate.toMap(),
            education: [educationContr!.text],
            phoneNumber: phoneContr!.text,
            surname: surnameContr!.text,
            uid: FirebaseAuth.instance.currentUser!.uid,
            createdAt: formatted,
          );
          setState(() {
            isLoading = true;
          });

          await FirebaseFirestore.instance
              .collection('Teachers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set(user.toMap())
              .then((value) async {
            await FirebaseAuth.instance.signOut();
            Get.snackbar(
              'Signing out',
              '',
            );
            print('Logged out');
          });
          if (_selectedImage != null) {
            await uploadImage(File(_selectedImage!.path));
          }
          setState(() {
            isLoading = false;
          });

          Get.offAll(() => const FirstScreen());

          print('name: ${nameContr!.text}');
          print('surname: ${surnameContr!.text}');
          print('email: ${emailContr!.text}');
          print('password: ${passwordContr!.text}');
          print('city: $selectedCity');
          print('city: $selectedGender');
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

  Widget forUplaodingImage() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          uploadImage(File(_selectedImage!.path));
        },
        child: const Text('upload the image'));
  }

  uploadImage(File file) async {
    //TODO: _loading when image i being uploaded

    final storageRef = FirebaseStorage.instance.ref();
    //if we have a user you can do it like this
    final imagesRef = storageRef.child("Teachers/${file.path}");
    imagesRef.putFile(file).snapshotEvents.listen((taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          debugPrint('running');
          break;
        case TaskState.paused:
          setState(() {
            isLoading = false;
          });
          debugPrint('paused');
          break;
        case TaskState.success:
          downloadUrl = await imagesRef.getDownloadURL();
          debugPrint('success, download url : $downloadUrl');
          break;
        case TaskState.canceled:
          debugPrint('cancel');
          setState(() {
            isLoading = false;
          });
          break;
        case TaskState.error:
          setState(() {
            isLoading = false;
          });
          debugPrint('error');
          break;
      }
    });
  }

  Widget datePicker(
      {required List<String> items,
      required double sizeWidth,
      required ValueChanged<String> valueChanged}) {
    return Container(
        margin: const EdgeInsets.all(8),
        width: 0.2 * sizeWidth,
        child: DropdownButtonFormField<String>(
          // value: selectedDay ?? items.first,
          items: items
              .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )))
              .toList(),
          onChanged: ((value) {
            valueChanged(value!);
          }),
        ));
  }
}
