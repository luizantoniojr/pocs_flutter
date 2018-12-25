import 'dart:convert';
import 'package:flutter/material.dart';
import 'file-service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];
  var _newTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FileService.readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  void _add() {
    setState(() {
      Map<String,dynamic> newTask = Map();
      newTask["title"] = _newTaskController.text;
      _newTaskController.text = "";
      newTask["ok"] = false;
      _toDoList.add(newTask);
    });
    var a = json.encode(_toDoList);
    FileService.saveData(a);
  }

  void _change(bool ok, num index) {
    setState(() {
      _toDoList[index]['ok'] = ok;
    });
    FileService.saveData(json.encode(_toDoList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de tarefas"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _newTaskController,
                      decoration: InputDecoration(
                          labelText: "Nova tarefa",
                          labelStyle: TextStyle(color: Colors.blueAccent)),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blueAccent,
                    child: Icon(Icons.add),
                    textColor: Colors.white,
                    onPressed: _add,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: _toDoList.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(_toDoList[index]['title'].toString()),
                      value: _toDoList[index]['ok'],
                      secondary: CircleAvatar(
                        child: Icon(
                            _toDoList[index]['ok'] ? Icons.check : Icons.error),
                      ),
                      onChanged: (value) {
                        _change(value, index);
                      },
                    );
                  }),
            )
          ],
        ));
  }
}
