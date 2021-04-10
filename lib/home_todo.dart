import 'package:db_final/todo.dart';
import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'insert_screen.dart';

class HomeTodo extends StatefulWidget {
  @override
  _HomeTodoState createState() => _HomeTodoState();
}

class _HomeTodoState extends State<HomeTodo> {
  DatabaseHelper databaseHelper;
  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper.instance;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Todos')),
      body: FutureBuilder(
          future: databaseHelper.retrieveTodos(),
          builder: (context, asyncSnapShotData) {
            if (asyncSnapShotData.connectionState == ConnectionState.done)
              return ListView.builder(
                itemCount: asyncSnapShotData.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(asyncSnapShotData.data[index].title),
                    leading: Text(asyncSnapShotData.data[index].id.toString()),
                    subtitle: Text(asyncSnapShotData.data[index].description),
                    onTap: () async {
                      int res = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return InsertScreen(
                          todo: asyncSnapShotData.data[index],
                        );
                      }));

                      if (res > 0) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Updation is Successful!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ));
                        setState(() {});
                      } else
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Updation is Unsuccessful!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ));
                    },
                    trailing: IconButton(
                        alignment: Alignment.center,
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          _deleteTodo(asyncSnapShotData.data[index]);
                          setState(() {});
                        }),
                  );
                },
              );
            else
              return Center(child: CircularProgressIndicator());
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      floatingActionButton: FloatingActionButton.extended(
        isExtended: false,
        label: Icon(Icons.add),
        onPressed: () async {
          int result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return InsertScreen();
          }));
          if (result > 0) {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Insertion is Successful!',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ));
            setState(() {});
          } else
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Insertion is Unsuccessful!',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ));
        },
      ),
    );
  }

  _deleteTodo(Todo todoObj) async {
    int del = await databaseHelper.deleteTodo(todoObj.id);
    del == 1
        ? _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(
                'Deletion is Successful!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(
                'Deletion is Unsuccessful!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
  }
}

//----------------------------updation of values----------------

// class Updation extends StatefulWidget {
//   final Todo todoObj;
//   Updation({this.todoObj});

//   @override
//   _UpdationState createState() => _UpdationState();
// }

// class _UpdationState extends State<Updation> {
//   TextEditingController _titleController;

//   TextEditingController _descriptionController;

//   DatabaseHelper _databaseHelper;

//   @override
//   void initState() {
//     super.initState();
//     _databaseHelper = DatabaseHelper.instance;
//     _descriptionController = TextEditingController();
//     _titleController = TextEditingController();
//     _titleController.text = widget.todoObj.title;
//     _descriptionController.text = widget.todoObj.description;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Updation'),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _titleController,
//                   decoration: InputDecoration(border: OutlineInputBorder()),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _descriptionController,
//                   decoration: InputDecoration(border: OutlineInputBorder()),
//                   maxLines: 10,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: OutlineButton(
//                   child: Text('UPDATE'),
//                   onPressed: () async {
//                     int res = await _databaseHelper.updateTodo(Todo(
//                         id: widget.todoObj.id,
//                         description: _descriptionController.text,
//                         title: _titleController.text));
//                     print('the updation $res');
//                     res == 1
//                         ? print('Data updation is Successful!')
//                         : print('Data updation is Unsuccessful!');
//                     Navigator.pop(context, res);
//                   },
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }
