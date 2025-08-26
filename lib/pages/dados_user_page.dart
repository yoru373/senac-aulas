// Importa o pacote principal do Flutter que contém widgets, temas, etc.
import 'package:flutter/material.dart';
import 'package:teste_app/services/shared_preferences_services.dart';

// Classe que representa a página de perfil
// StatefulWidget é usado porque algumas partes mudam dinamicamente (ex: cor da borda, visibilidade da senha)
class DadosUserPage extends StatefulWidget {
  const DadosUserPage({
    super.key,
  }); // Construtor com chave opcional (boa prática para widgets)

  @override
  State<DadosUserPage> createState() => _DadosUserPageState();
}

// Estado associado à página de perfil
class _DadosUserPageState extends State<DadosUserPage> {
  // Variável que controla se a senha está visível ou oculta
  bool isObcure = true;
  Color corBorda = Colors.blue;
  String? login;
  String? senha;

  @override
  initState() {
    super.initState();
    staloadSharedPreferences();
  }

  void staloadSharedPreferences() async {
    String? loginStorage =
        await SharedPreferencesServices.getStringlocalStorage("login");
    String? senhaStorage =
        await SharedPreferencesServices.getStringlocalStorage("senha");
    setState(() {
      login = loginStorage;
      senha = senhaStorage;
    });
  }

  // Controladores para capturar o texto digitado nos campos de login e senha
  TextEditingController controllerLogin = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estrutura base da tela (AppBar + Body)
      appBar: AppBar(
        toolbarOpacity: 0.7, // Transparência da barra
        foregroundColor: Colors.black, // Cor do texto e ícones
        backgroundColor: Colors.blueAccent, // Cor de fundo da barra
        title: Text("Meu perfil"), // Título no AppBar
      ),

      // Espaçamento geral da página
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

        // ListView permite rolar a tela para evitar overflow em telas menores
        child: ListView(
          children: [
            Text(login ?? "não tenho dados do login"),
            Text(senha ?? "não tenho dados da senha"),
          ],
        ),
      ),
    );
  }
}
