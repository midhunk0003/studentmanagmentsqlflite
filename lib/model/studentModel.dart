class StudentModel {
  int? id;
  final String name;
  final String age;
  final String mobile;
  final String email;

  StudentModel(
      {required this.name,
      required this.age,
      required this.mobile,
      required this.email,
      this.id});

  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final mobile = map['mobile'] as String;
    final email = map['email'] as String;

    return StudentModel(
      name: name,
      age: age,
      mobile: mobile,
      email: email,
      id: id,
    );
  }
}
