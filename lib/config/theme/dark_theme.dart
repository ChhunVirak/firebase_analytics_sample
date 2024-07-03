// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'page_transition.dart';

ThemeData darkTheme = ThemeData.dark(
        // useMaterial3: true,
        )
    .copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);

class Student {
  final String name;
  final int age;
  Student(
    this.name,
    this.age,
  );

  Student copyWith({
    String? name,
    int? age,
  }) {
    return Student(
      name ?? this.name,
      age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      map['name']?.toString() as String,
      map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Student(name: $name, age: $age)';

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}

extension ModelValidator on dynamic {
  String? get stringOrNull => this?.toString();
}
