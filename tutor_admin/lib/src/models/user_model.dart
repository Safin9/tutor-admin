// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

class UserModelReady {
  String name;
  String surname;
  String? email;
  String? lessonType;
  String currentCity;
  String gender;
  String uid;
  String? imageUrl;
  String? phoneNumber;
  String? shortbio;
  String? tacherOrStudent;
  int? star;
  String createdAt;
  Map<String, dynamic>? birthDate;
  List<String>? education;
  List<String>? languages;
  UserModelReady({
    required this.name,
    required this.surname,
    this.email,
    this.lessonType,
    required this.currentCity,
    required this.gender,
    required this.uid,
    this.imageUrl,
    this.phoneNumber,
    this.shortbio,
    this.tacherOrStudent,
    this.star,
    required this.createdAt,
    this.birthDate,
    this.education,
    this.languages,
  });

  UserModelReady copyWith({
    String? name,
    String? surname,
    String? email,
    String? lessonType,
    String? currentCity,
    String? gender,
    String? uid,
    String? imageUrl,
    String? phoneNumber,
    String? shortbio,
    String? tacherOrStudent,
    int? star,
    String? createdAt,
    Map<String, dynamic>? birthDate,
    List<String>? education,
    List<String>? languages,
  }) {
    return UserModelReady(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      lessonType: lessonType ?? this.lessonType,
      currentCity: currentCity ?? this.currentCity,
      gender: gender ?? this.gender,
      uid: uid ?? this.uid,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      shortbio: shortbio ?? this.shortbio,
      tacherOrStudent: tacherOrStudent ?? this.tacherOrStudent,
      star: star ?? this.star,
      createdAt: createdAt ?? this.createdAt,
      birthDate: birthDate ?? this.birthDate,
      education: education ?? this.education,
      languages: languages ?? this.languages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'email': email,
      'lessonType': lessonType,
      'currentCity': currentCity,
      'gender': gender,
      'uid': uid,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'shortbio': shortbio,
      'tacherOrStudent': tacherOrStudent,
      'star': star,
      'createdAt': createdAt,
      'birthDate': birthDate,
      'education': education,
      'languages': languages,
    };
  }
  // factory from document snapshot

  factory UserModelReady.fromSnapShot(DocumentSnapshot documentSnapshot) {
    return UserModelReady.fromMap(
        documentSnapshot.data() as Map<String, dynamic>,
        reference: documentSnapshot.reference);
  }
  factory UserModelReady.fromMap(Map<String, dynamic> map,
      {DocumentReference? reference}) {
    return UserModelReady(
      name: map['name'] as String,
      surname: map['surname'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      lessonType:
          map['lessonType'] != null ? map['lessonType'] as String : null,
      currentCity: map['currentCity'] as String,
      gender: map['gender'] as String,
      uid: map['uid'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      shortbio: map['shortbio'] != null ? map['shortbio'] as String : null,
      tacherOrStudent: map['tacherOrStudent'] != null
          ? map['tacherOrStudent'] as String
          : null,
      star: map['star'] != null ? map['star'] as int : null,
      createdAt: map['createdAt'] as String,
      // createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      birthDate: map['birthDate'] != null
          ? Map<String, dynamic>.from(
              (map['birthDate'] as Map<String, dynamic>))
          : null,
      education: map['education'] != null
          ? List<String>.from((map['education'] as List<dynamic>))
          : null,
      languages: map['languages'] != null
          ? List<String>.from((map['languages'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModelReady.fromJson(String source) =>
      UserModelReady.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModelReady(name: $name, surname: $surname, email: $email, lessonType: $lessonType, currentCity: $currentCity, gender: $gender, uid: $uid, imageUrl: $imageUrl, phoneNumber: $phoneNumber, shortbio: $shortbio, tacherOrStudent: $tacherOrStudent, star: $star, createdAt: $createdAt, birthDate: $birthDate, education: $education, languages: $languages)';
  }

  @override
  bool operator ==(covariant UserModelReady other) {
    if (identical(this, other)) return true;
    final collectionEquals = const DeepCollectionEquality().equals;

    return other.name == name &&
        other.surname == surname &&
        other.email == email &&
        other.lessonType == lessonType &&
        other.currentCity == currentCity &&
        other.gender == gender &&
        other.uid == uid &&
        other.imageUrl == imageUrl &&
        other.phoneNumber == phoneNumber &&
        other.shortbio == shortbio &&
        other.tacherOrStudent == tacherOrStudent &&
        other.star == star &&
        other.createdAt == createdAt &&
        collectionEquals(other.birthDate, birthDate) &&
        collectionEquals(other.education, education) &&
        collectionEquals(other.languages, languages);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        surname.hashCode ^
        email.hashCode ^
        lessonType.hashCode ^
        currentCity.hashCode ^
        gender.hashCode ^
        uid.hashCode ^
        imageUrl.hashCode ^
        phoneNumber.hashCode ^
        shortbio.hashCode ^
        tacherOrStudent.hashCode ^
        star.hashCode ^
        createdAt.hashCode ^
        birthDate.hashCode ^
        education.hashCode ^
        languages.hashCode;
  }
}
