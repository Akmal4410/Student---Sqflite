import 'dart:math';

class Student {
  int? id;
  final String name;
  final int age;

  Student({
    this.id,
    required this.name,
    required this.age,
  });

  static Student fromMap(Map<String, Object?> item) {
    return Student(
      id: item['id'] as int,
      name: item['name'] as String,
      age: item['age'] as int,
    );
  }
}
