import 'dart:convert';
import 'package:flutter/material.dart';
import 'file-service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _formKey = GlobalKey<FormState>();
  List _toDoList = [];
  Map<String, dynamic> _lastRemoved;
  int _indexLastRemoved;
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
    if (_formKey.currentState.validate()) {
      setState(() {
        Map<String, dynamic> newTask = Map();
        newTask["title"] = _newTaskController.text;
        _newTaskController.text = "";
        newTask["ok"] = false;
        _toDoList.add(newTask);
      });
      _saveData();
    }
  }

  void _change(bool ok, num index) {
    setState(() {
      _toDoList[index]['ok'] = ok;
    });
  }

  void _remove(BuildContext context, int index) {
    setState(() {
      _lastRemoved = Map.from(_toDoList[index]);
      _indexLastRemoved = index;
      _toDoList.removeAt(index);
      _saveData();
      Scaffold.of(context).showSnackBar(_buildSnackBar());
    });
  }

  void _undo() {
    setState(() {
      _toDoList.insert(_indexLastRemoved, _lastRemoved);
      _saveData();
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _toDoList.sort((a, b) {
        if (a['ok'] && !b['ok'])
          return 1;
        else if (!a['ok'] && b['ok'])
          return -1;
        else
          return 0;
      });
      _saveData();
    });
  }

  void _saveData() {
    FileService.saveData(json.encode(_toDoList));
  }

  Widget _buildSnackBar() {
    return SnackBar(
      content: Text("Item ${_lastRemoved["title"]} removida."),
      action: SnackBarAction(
        label: "Desfazer",
        onPressed: _undo,
      ),
      duration: Duration(seconds: 2),
    );
  }

  Dismissible _builderListTile(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.delete, color: Colors.white),
              Text(
                "Remover",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        _remove(context, index);
      },
      child: CheckboxListTile(
        title: Text(_toDoList[index]['title'].toString()),
        value: _toDoList[index]['ok'],
        secondary: CircleAvatar(
            child: Icon(_toDoList[index]['ok']
                ? Icons.shopping_basket
                : Icons.error_outline)),
        onChanged: (value) {
          _change(value, index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista do mercado"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(27.0, 10.0, 2.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _newTaskController,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Informe a descrição do item";
                        },
                        decoration: InputDecoration(
                            labelText: "Novo item",
                            labelStyle: TextStyle(color: Colors.blueAccent)),
                      ),
                    ),
                    RaisedButton(
                      shape: CircleBorder(),
                      color: Colors.blueAccent,
                      child: Icon(Icons.add),
                      textColor: Colors.white,
                      onPressed: _add,
                    )
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount: _toDoList.length,
                      itemBuilder: _builderListTile),
                ),
              )
            ],
          ),
        ));
  }
}
