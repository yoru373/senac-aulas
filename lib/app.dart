import 'package:flutter/material.dart';
import 'package:teste_app/pages/cep_api_page.dart';
import 'package:teste_app/pages/dados_user_page.dart';
import 'package:teste_app/pages/home_page.dart';
import 'package:teste_app/pages/perfil_page.dart';

// Classe principal do app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define a rota inicial ao abrir o app
      initialRoute: "/viaCepApi",

      // Mapeamento de rotas para as páginass
      routes: {
        "/home": (context) => HomePage(), // Rota da página Home
        "/perfil": (context) => PerfilPage(), // Rota da página Perfil
        "/dadosUsuario": (context) => DadosUserPage(),
        "/viaCepApi": (context) => CepApiPage(),
      },

      // Remove a faixa de debug no canto da tela
      debugShowCheckedModeBanner: false,

      // Título do aplicativo
      title: 'Flutter Demo',

      // Definição do tema (baseado em cor semente)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
