import 'package:flutter/material.dart';
import 'verificador_senha.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verificador de Senha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VerificadorSenha(),
    );
  }
}
