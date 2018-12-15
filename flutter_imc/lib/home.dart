import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _formKey = GlobalKey<FormState>();
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  String _info = '';
  String _imc = '';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _info = '';
      _imc = '';
    });
  }

  void _calcule() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      _imc = "IMC = ${imc.toStringAsPrecision(3)}";
      if (imc < 18.6) {
        _info = "Abaixo do peso";
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = "Peso ideal";
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = "Levemente acima do peso";
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = "Obesidade grau 1";
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = "Obesidade grau 2";
      } else if (imc >= 40 && imc < 100) {
        _info = "Obesidade grau 3";
      } else {
        _info = "Algo de errado não está certo!";
        _imc = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) return "Informe o seu peso";
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) return "Informe a sua altura";
                },
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: 90.0,
                child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) _calcule();
                    },
                    child: Text("Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    color: Colors.green),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              Text(
                _imc,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
