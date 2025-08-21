// Importa o pacote principal do Flutter que contém widgets, temas, etc.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_app/list/apps_list.dart';
import 'package:teste_app/services/shared_preferences_services.dart';
import 'package:teste_app/widgets/custom_title.dart';


// Classe que representa a página de perfil
// StatefulWidget é usado porque algumas partes mudam dinamicamente (ex: cor da borda, visibilidade da senha)
class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key}); // Construtor com chave opcional (boa prática para widgets)

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

// Estado associado à página de perfil
class _PerfilPageState extends State<PerfilPage> {
  // Variável que controla se a senha está visível ou oculta
  bool isObcure = false;

  // Cor da borda da foto de perfil — pode ser alterada clicando nos botões de cor
  Color corBorda = Colors.blue;

List<Map<String, dynamic>> ListInfo = [{"title":"meu nome", "Icons":"Icons.person_3","subtitle":"ado"},
{"title":"meu nome", "Icons":"Icons.person_3","subtitle":"ado"},
{"title":"meu nome", "Icons":"Icons.person_3","subtitle":"ado"}];
  // Controladores para capturar o texto digitado nos campos de login e senha
  TextEditingController controllerLogin = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Estrutura base da tela (AppBar + Body)
      appBar: AppBar(
        actions: [
     Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/dadosUsuario");
        },
        child: Icon(Icons.settings),
      ),
     )
        ],
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
            Column( // Agrupa elementos verticalmente
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Foto de perfil dentro de um Stack para sobrepor o ícone de câmera
                Stack(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(5), // Espaço entre foto e borda
                        decoration: BoxDecoration(
                          color: corBorda, // Borda colorida
                          shape: BoxShape.circle, // Formato circular
                        ),
                        child: ClipOval( // Garante que a imagem fique redonda
                          child: Image.network(
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover, // Preenche espaço sem distorcer
                            "https://i.pinimg.com/736x/cb/4e/c4/cb4ec47ec6fdd971740ee5182c453d08.jpg", // URL da imagem
                          ),
                        ),
                      ),
                    ),

                    // Ícone de câmera posicionado sobre a foto
                    Positioned(
                      right: 135, // Distância da direita
                      bottom: 7,  // Distância de baixo
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.camera),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),

                // Linha com três botões que mudam a cor da borda da foto
                Row(
                  children: [
                    Expanded( // Ocupa espaço proporcional na tela
                      child: GestureDetector( // Detecta toques
                        onTap: () {
                          setState(() { // Atualiza o estado da tela
                            corBorda = Colors.blue;
                          });
                        },
                        child: Container(
                          color: Colors.blueAccent,
                          child: Text("azul"),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            corBorda = Colors.black;
                          });
                        },
                        child: Container(
                          color: Colors.black,
                          child: Text("preto"),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            corBorda = Colors.amber;
                          });
                        },
                        child: Container(
                          color: Colors.amber,
                          child: Text("amarelo"),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20), // Espaçamento vertical

                // Exibe nome do usuário
              
              CustomTitle(title: "meu nome", icon: Icons.person_4, subtitle: "ado"),

                SizedBox(height: 20),

                // Exibe e-mail do usuário
                  CustomTitle(title: "meu email", icon: Icons.email, subtitle: "ado@gmail.com"),

                SizedBox(height: 20),

                  CustomTitle(title: "Meu cargo", icon: Icons.business, subtitle: "desenvolvedor"),

                // Formulário para login
                Form(
                  child: Column(
                    children: [
                      ...AppsList.listTitles.map((Title){
                        return CustomTitle(title: Title["title"], icon: Title["icon"], subtitle: Title["valor"]);
                      }),
                      SizedBox(
                        child: TextFormField(
                          maxLength: 10, // Máximo de caracteres
                          controller: controllerLogin, // Controla o valor digitado
                          decoration: InputDecoration(
                            labelText: "login", // Texto do campo
                            focusedBorder: OutlineInputBorder( // Borda quando focado
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder( // Borda quando não focado
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Formulário para senha
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 10,
                        controller: controllerSenha,
                        obscureText: isObcure, // Mostra/oculta senha
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isObcure = !isObcure; // Alterna visibilidade
                              });
                            },
                            child: Icon(
                              isObcure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          labelText: "senha",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Botão para enviar login e senha
                SizedBox(
                  width: 257,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(
                        const Color.fromARGB(255, 4, 28, 240),
                      ),
                      backgroundColor: WidgetStatePropertyAll(Colors.black),
                    ),
                    onPressed: ()  async{
                      // Apenas imprime no console — aqui poderia ter lógica de autenticação
                      print(controllerLogin.text);
                      print(controllerSenha.text);

                    await SharedPreferencesServices.setStringLocalStorage(
                        controllerLogin.text,
                        "login",
                      );

                    await SharedPreferencesServices.setStringLocalStorage(
                        controllerSenha.text,
                        "senha",
                      );
                    },
                    child: Text("Realizar login"),
                  ),
                ),

                // Seção de bio do artista
                Row(
                  children: [
                    Icon(Icons.person_2),
                    SizedBox(width: 5),
                    Text(
                      "bio",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                // Caixa cinza com texto descritivo
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Ado é uma cantora japonesa que conquistou fama mundial..."
                    // Texto longo descrevendo o artista
                  ),
                ),

                // Botão para voltar para a página inicial
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                    backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                  ),
                  onPressed: () {
                    print("cliquei");
                    Navigator.pushNamed(context, "/home"); // Navega para rota "/home"
                  },
                  child: Text("volta para home"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
