import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_crud_sqlflite/SQLDB.dart';
import 'package:student_crud_sqlflite/home.dart';

class UpdateStudent extends StatefulWidget {
  final id;
  final name;
  final age;
  const UpdateStudent({Key? key, this.id, this.name, this.age})
      : super(key: key);
  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  var _nameController = TextEditingController();

  var _ageController = TextEditingController();

  SQLdb sqLdb = SQLdb();
  final _form_key = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController.text = widget.name;
    _ageController.text = widget.age.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('UPDATE STUDENT')),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _form_key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'name field is required';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _ageController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'age',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'age field is required';
                  } else {
                    return null;
                  }
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_form_key.currentState!.validate()) {
                    int rep = await sqLdb.updateData(
                        ''' UPDATE "studentdetails" SET name = "${_nameController.text}", age = ${int.parse(_ageController.text.toString())} WHERE id = '${widget.id}'
                      ''');
                    print(rep);
                    if (rep > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (ctx) {
                        return HomeMain();
                      }), (route) => false);
                    }
                  } else {
                    print('data empty');
                  }
                },
                child: Text('UPDATE STUDENT'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
