// Importa o pacote principal do Flutter que contém widgets, temas, etc.
import 'package:flutter/material.dart';
// Permite aplicar filtros de entrada (ex: apenas números)
import 'package:flutter/services.dart';
// Importa o modelo de Endereço (estrutura de dados que armazena logradouro, bairro, etc.)
import 'package:teste_app/models/endereco_model.dart';
// Importa o serviço que busca dados de CEP via API do ViaCEP
import 'package:teste_app/services/via_cep_service.dart';

// Página de consulta de CEP (StatefulWidget pois a tela precisa atualizar ao receber dados da API)
class CepApiPage extends StatefulWidget {
  const CepApiPage({
    super.key,
  }); // Construtor com chave opcional (boa prática para widgets)

  @override
  State<CepApiPage> createState() => _CepUserPageState();
}

// Estado da página (onde ficam variáveis e lógica dinâmica)
class _CepUserPageState extends State<CepApiPage> {
  // Objeto que receberá os dados retornados pela API (endereço completo)
  Endereco? endereco;

  // Instância do serviço responsável por buscar os dados do CEP
  ViaCepService viaCepService = ViaCepService();

  @override
  initState() {
    super.initState();
    // Aqui poderia inicializar variáveis ou carregar dados automaticamente se necessário
  }

  // Controlador que captura o texto digitado no campo de CEP
  TextEditingController controllerCEP = TextEditingController();

  // Controladores que poderiam ser usados futuramente para login/senha (não utilizados aqui)
  TextEditingController controllerLogin = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estrutura base da tela (AppBar + Body)
      appBar: AppBar(
        toolbarOpacity: 0.7, // Define a transparência da AppBar
        foregroundColor: Colors.black, // Cor dos textos e ícones na AppBar
        backgroundColor: Colors.blueAccent, // Cor de fundo da AppBar
        title: Text("Meu perfil"), // Título exibido na AppBar
      ),

      // Corpo da página com espaçamento nas laterais e no topo
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

        // ListView permite rolagem (importante em telas pequenas para evitar overflow)
        child: ListView(
          children: [
            // Campo de texto para digitar o CEP
            TextField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ], // Permite apenas números
              maxLength: 8, // Limite de 8 dígitos (formato padrão de CEP)
              keyboardType: TextInputType.number, // Abre teclado numérico
              controller: controllerCEP, // Controlador vinculado ao campo
              decoration: InputDecoration(
                labelText: "Digite o cep", // Rótulo do campo
                suffixIcon: GestureDetector(
                  child: Icon(Icons.search), // Ícone de busca ao lado do campo
                  onTap: () async {
                    // Quando o ícone é clicado:
                    setState(() {
                      endereco = null; // Limpa o estado anterior
                    });

                    // Chama o serviço ViaCEP passando o valor digitado
                    dynamic enderecoResposta = await viaCepService
                        .buscarEndereco(controllerCEP.text);

                    // Se o retorno for um objeto Endereco válido, atualiza o estado
                    if (enderecoResposta is Endereco) {
                      setState(() {
                        endereco = enderecoResposta;
                      });
                    }
                  },
                ),
                hintText: "Ex: 45000000", // Texto de exemplo
                hintStyle: TextStyle(
                  color: Colors.grey,
                ), // Estilo do texto de exemplo
                border: OutlineInputBorder(), // Borda do campo de texto
              ),
            ),

            // Exibe os dados do endereço apenas se o objeto "endereco" não for nulo
            if (endereco != null)
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alinha textos à esquerda
                children: [
                  Text(
                    "Logradouro",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(endereco!.logradouro!),

                  Text("Bairro", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco!.bairro!),

                  Text(
                    "Localidade",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(endereco!.localidade!),

                  Text("Estado", style: TextStyle(fontWeight: FontWeight.bold)),
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
