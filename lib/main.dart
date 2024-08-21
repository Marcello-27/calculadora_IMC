import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: Home(), debugShowCheckedModeBanner: false),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso(${imc})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Acima do Peso";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora IMC', style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.teal[800],
          actions: [
            IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.person_2_sharp,
                      size: 120,
                      color: Colors.teal[600],
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso (kg)",
                          labelStyle: TextStyle(color: Colors.teal[600])),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.teal[600], fontSize: 25.0),
                      controller: weightController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Insira seu Peso!";
                        }
                      },
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Altura (m)",
                            labelStyle: TextStyle(color: Colors.teal[600])),
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.teal[600], fontSize: 25.0),
                        controller: heightController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Insira sua Altura!";
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _calculate();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[800]),
                          child: Text(
                            'Calcular',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.teal[800], fontSize: 25),
                    )
                  ],
                ))));
  }
}
