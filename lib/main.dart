import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var weightcontroller = TextEditingController();
  var heightcontroller = TextEditingController();
  String _infoText = 'Informe seus dados!';

  var _formKey = GlobalKey<FormState>();

  void _calcularImc() {
    setState(() {
      double peso = double.parse(weightcontroller.text);
      double altura = double.parse(heightcontroller.text);
      double imc = peso / pow((altura / 100), 2);

      if (weightcontroller.text == '' || heightcontroller.text == '') {
        _infoText = 'Informe seus dados!';
      } else if (imc < 16) {
        _infoText = 'Magreza Grave (${imc.toStringAsFixed(1)})';
      } else if (imc >= 16 && imc < 17) {
        _infoText = 'Magreza Moderada (${imc.toStringAsFixed(1)})';
      } else if (imc >= 17 && imc < 18.5) {
        _infoText = 'Magreza Leve (${imc.toStringAsFixed(1)})';
      } else if (imc >= 18.5 && imc < 25) {
        _infoText = 'Saudável (${imc.toStringAsFixed(1)})';
      } else if (imc >= 25 && imc < 30) {
        _infoText = 'Sobrepeso (${imc.toStringAsFixed(1)})';
      } else if (imc >= 30 && imc < 35) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsFixed(1)})';
      } else if (imc >= 35 && imc < 40) {
        _infoText = 'Obesidade Grau II (${imc.toStringAsFixed(1)})';
      } else {
        _infoText = 'Obesidade Grau III (${imc.toStringAsFixed(1)})';
      }
    });
  }

  void _resetField() {
    weightcontroller.text = '';
    heightcontroller.text = '';
    setState(() {
      _formKey = GlobalKey<FormState>();
      _infoText = 'Informe seus dados!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora de IMC',
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetField)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp('[0-9.]'))
                ],
                decoration: InputDecoration(
                  labelText: 'Peso em (kg)',
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                controller: weightcontroller,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu Peso!";
                  }
                },
              ),
              TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                controller: heightcontroller,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua Altura!!";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calcularImc();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
