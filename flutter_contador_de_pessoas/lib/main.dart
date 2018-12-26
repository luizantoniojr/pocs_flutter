import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Contador de pessoas',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0;
  String _infoText = 'Pode entrar!';

  void _addPeople() {
    setState(() {
      _people++;
      if (_people > 10)
        _infoText = 'Lotado!!!';
      else
        _infoText = 'Pode entrar!';
    });
  }

  void _removePeople() {
    setState(() {
      _people--;
      if (_people > 0)
        _infoText = 'Pode entrar!';
      else
        _infoText = 'Mundo invertido?!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'images/background-papel.png',
          fit: BoxFit.cover,
          height: 1000.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pessoas $_people',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text('+1',
                        style: TextStyle(fontSize: 40.0, color: Colors.white)),
                    onPressed: () {
                      _addPeople();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text('-1',
                        style: TextStyle(fontSize: 40.0, color: Colors.white)),
                    onPressed: () {
                      _removePeople();
                    },
                  ),
                ),
              ],
            ),
            Text(
              _infoText,
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.00),
            )
          ],
        )
      ],
    );
  }
}
