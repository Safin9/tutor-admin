// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BirthDateModel {
  int year;
  int month;
  int day;
  BirthDateModel({
    required this.year,
    required this.month,
    required this.day,
  });

  BirthDateModel copyWith({
    int? year,
    int? month,
    int? day,
  }) {
    return BirthDateModel(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'year': year,
      'month': month,
      'day': day,
    };
  }

  factory BirthDateModel.fromSnapShot(DocumentSnapshot documentSnapshot) {
    return BirthDateModel.fromMap(
        documentSnapshot.data() as Map<String, dynamic>,
        reference: documentSnapshot.reference);
  }
  factory BirthDateModel.fromMap(Map<String, dynamic> map,
      {DocumentReference? reference}) {
    return BirthDateModel(
      year: map['year'] as int,
      month: map['month'] as int,
      day: map['day'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BirthDateModel.fromJson(String source) =>
      BirthDateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BirthDateModel(year: $year, month: $month, day: $day)';

  @override
  bool operator ==(covariant BirthDateModel other) {
    if (identical(this, other)) return true;

    return other.year == year && other.month == month && other.day == day;
  }

  @override
  int get hashCode => year.hashCode ^ month.hashCode ^ day.hashCode;
}
