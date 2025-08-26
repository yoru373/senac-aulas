// Importa o pacote principal do Flutter que contém widgets, temas, etc.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_app/models/endereco_model.dart';
import 'package:teste_app/services/via_cep_service.dart';

// Classe que representa a página de perfil
// StatefulWidget é usado porque algumas partes mudam dinamicamente (ex: cor da borda, visibilidade da senha)
class CepApiPage extends StatefulWidget {
  const CepApiPage({
    super.key,
  }); // Construtor com chave opcional (boa prática para widgets)

  @override
  State<CepApiPage> createState() => _CepUserPageState();
}

// Estado associado à página de perfil
class _CepUserPageState extends State<CepApiPage> {
  // Variável que controla se a senha está visível ou oculta
  Endereco? endereco;

  ViaCepService viaCepService = ViaCepService();

  @override
  initState() {
    super.initState();
  }

  TextEditingController controllerCEP = TextEditingController();

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
            TextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 8,
              keyboardType: TextInputType.number,
              controller: controllerCEP,
              decoration: InputDecoration(
                labelText: "Digite o cep",
                suffixIcon: GestureDetector(
                  child: Icon(Icons.search),
                  onTap: () async {
                    setState(() {
                      endereco = null;
                    });

                    dynamic enderecoResposta = await viaCepService
                        .buscarEndereco(controllerCEP.text);

                    if (enderecoResposta is Endereco) {
                      setState(() {
                        endereco = enderecoResposta;
                      });
                    }
                  },
                ),
                hintText: "Ex: 450000",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            if (endereco != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "logradouro",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(endereco!.logradouro!),
                  Text("bairro", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco!.bairro!),
                  Text(
                    "localidade",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(endereco!.localidade!),
                  Text("estado", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco!.estado!),
                  Text("Região", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco!.regiao!),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
