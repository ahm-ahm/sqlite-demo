import 'package:db_final/database_helper.dart';
import 'package:db_final/todo.dart';
import 'package:flutter/material.dart';

class InsertScreen extends StatefulWidget {
  final Todo todo;

  const InsertScreen({Key key, this.todo}) : super(key: key);

  @override
  _InsertScreenState createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {
  DatabaseHelper _databaseHelper;
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  Todo todo;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _databaseHelper = DatabaseHelper.instance;

    if (widget.todo != null) {
      _titleController.text = widget.todo.title;
      _descriptionController.text = widget.todo.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.todo == null ? 'ADD TODO' : 'UPDATE TODO'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    labelText: 'Name', border: OutlineInputBorder()),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    labelText: 'Description', border: OutlineInputBorder()),
                maxLines: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineButton(
                onPressed: () async {
                  if (widget.todo != null) {
                    todo = Todo(
                        id: widget.todo.id,
                        title: _titleController.text,
                        description: _descriptionController.text);

                    int updatedValue = await _databaseHelper.updateTodo(todo);

                    Navigator.pop(context, updatedValue);
                  } else {
                    todo = Todo(
                        title: _titleController.text,
                        description: _descriptionController.text);
                    int noOfAffectedRows =
                        await _databaseHelper.insertTodo(todo);
                    print('the insertion is =$noOfAffectedRows');

                    Navigator.pop(context, noOfAffectedRows);
                  }
                },
                child: Text(widget.todo == null ? 'ADD' : 'UPDATE'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
