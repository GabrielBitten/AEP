import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerificadorSenha extends StatefulWidget {
  const VerificadorSenha({super.key});

  @override
  _VerificadorSenhaState createState() => _VerificadorSenhaState();
}

class _VerificadorSenhaState extends State<VerificadorSenha> {
  final TextEditingController _controller = TextEditingController();
  int _passwordStrength = -1; 
  String _strengthText = ""; 
  List<Map<String, String>> _savedPasswords = []; 

  Future<void> checkPasswordStrength(String password) async {
    final response = await http.post(
      // Quando testar, altere pelo ip do seu PC
      Uri.parse('http://192.168.25.2:5000/predict'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'senha': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Dados:$data'); 
      setState(() {
        _passwordStrength = data['strength'];
        _strengthText = _getStrengthText(_passwordStrength);
      });
    } else {
      throw Exception('Falha ao verificar a força da senha');
    }
  }

  Color _getStrengthColor(int strength) {
    switch (strength) {
      case 0: 
        return Colors.red;
      case 1: 
        return Colors.orange;
      case 2:
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  String _getStrengthText(int strength) {
    switch (strength) {
      case 0:
        return 'Senha Fraca';
      case 1:
        return 'Senha Mediana';
      case 2:
        return 'Senha Forte';
      default:
        return '';
    }
  }

  void _savePassword() {
    setState(() {
      _savedPasswords.add({
        'password': _controller.text,
        'strength': _strengthText,
      });
    });

    _controller.clear();
    _passwordStrength = -1;
    _strengthText = '';
  }

  void _deletePassword(int index) {
    setState(() {
      _savedPasswords.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    const double buttonWidth = 150; 
    const double buttonHeight = 50;
    const double fontSize = 16; 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Verificador de Senha',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Digite a senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: _savePassword,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15), 
                  minimumSize: const Size(buttonWidth, buttonHeight), 
                  textStyle: const TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), 
                  ),
                ),
                onPressed: () {
                  checkPasswordStrength(_controller.text);
                },
                child: const Text(
                  'Verificar Força',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              if (_passwordStrength != -1)
                Container(
                  width: buttonWidth,
                  height: buttonHeight,
                  color: _getStrengthColor(_passwordStrength),
                  alignment: Alignment.center,
                  child: Text(
                    _strengthText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize, 
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                'Senhas Salvas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _savedPasswords.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), 
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _savedPasswords[index]['password']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  _savedPasswords[index]['strength']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            
                            icon: const Icon(Icons.close),
                            onPressed: () => _deletePassword(index),
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
