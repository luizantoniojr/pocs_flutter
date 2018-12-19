import 'package:flutter/material.dart';

class Tema {
  static Widget obterCampoTexto(String labelText, String prefixText,
      TextEditingController controller, Function onChanged) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.amber),
          border: OutlineInputBorder(),
          prefixText: prefixText),
      style: TextStyle(color: Colors.amber, fontSize: 25.0),
      keyboardType: TextInputType.number,
    );
  }
}
