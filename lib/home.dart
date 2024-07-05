import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:student_crud_sqlflite/SQLDB.dart';
import 'package:student_crud_sqlflite/updateStudent.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  SQLdb sqLdb = SQLdb();

  //--------------get all students -----------------//
  Future<List<Map>> getAllStudents() async {
    List<Map> students = await sqLdb.getData("SELECT * FROM 'studentdetails'");
    return students;
  }

  //--------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('addStudent');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Center(child: Text('STUDENT DATA APP')),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                flex: 11,
                child: Container(
                  color: Color.fromARGB(255, 234, 234, 234),
                  height: 30,
                  child: FutureBuilder(
                    future: getAllStudents(),
                    builder: (ctx, snp) {
                      if (snp.hasData) {
                        List<Map> liststudents = snp.data!;
                        if (liststudents.isNotEmpty) {
                          return InkWell(
                            onTap: (){
                              
                            },
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return Container(
                                  height: 100,
                                  child: Card(
                                    elevation: 29,
                                    margin: EdgeInsets.all(10),
                                    color: Color.fromARGB(255, 5, 169, 68),
                                    shadowColor: Colors.grey,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 25,
                                      ),
                                      title: Text(
                                        "${liststudents[index]['name']}",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color:
                                                Color.fromARGB(255, 213, 73, 7)),
                                      ),
                                      // subtitle: Text(
                                      //   "age :${liststudents[index]['age']}",
                                      //   style: TextStyle(
                                      //       fontSize: 25,
                                      //       color:
                                      //           const Color.fromARGB(255, 5, 5, 5)),
                                      // ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (ctx) {
                                                return UpdateStudent(
                                                  id: liststudents[index]['id'],
                                                  name: liststudents[index]
                                                      ['name'],
                                                  age: liststudents[index]['age'],
                                                );
                                              }));
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              showDilogefunction(
                                                ctx,
                                                liststudents[index]['id'],
                                                liststudents[index]['name'],
                                              );
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return Divider();
                              },
                              itemCount: liststudents.length,
                            ),
                          );
                        } else {
                          return Center(child: Text('NO STUDENT RECORD'));
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
              ///////////////////////////
              ElevatedButton(
                onPressed: () async {
                  int rep = await sqLdb.insertData(
                      "INSERT INTO 'users' (username,email) VALUES ('midhun','midhun@gmail.com')");
                  print(rep);
                },
                child: Text('ADD DATA'),
              ),

              /////////////////////////
              ElevatedButton(
                onPressed: () async {
                  List<Map> rep = await sqLdb.getData("SELECT * FROM 'users'");
                  print(rep);
                },
                child: Text('ADD DATA'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> successAlert(BuildContext ctx) {
    return showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          title: Text('success'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showDilogefunction(BuildContext ctx, id, name) {
    showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          title: Text('ARE YOU SURE TO DELETE ${name}'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                int rep = await sqLdb.deleteData(
                    "DELETE FROM 'studentdetails' WHERE id = ${id.toString()}");
                if (rep > 0) {
                  Navigator.of(ctx).pop();
                  setState(() {});
                }
              },
              child: Text('delete'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
              },
              child: Text('not'),
            ),
          ],
        );
      },
    );
  }
}
