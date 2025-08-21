// Classe AppList para armazenar e manipular listas
class EstudosList {
  
  // Lista de nomes (apenas Strings)
  List<String> nameList = ["diego", "kaique", "bia", "andrey"];

  // Lista de números inteiros
  List<int> numberList = [1, 2, 3, 4, 5];

  // Lista mista (pode conter diferentes tipos de dados)
  List<dynamic> mixList = [
    1,                    // número inteiro
    "diego",              // string
    true,                 // boolean
    () {                  // função anônima
      print("imprime na tela");
    }
  ];

  Map<String, dynamic> dadosDiego = {"nome": "diego", "idade": 40, "nacionalidade":"brasileiro"};



  // Método que imprime elementos da lista de nomes
  void imprimirLista() {
    // Acessa diretamente o primeiro item da lista
    print(nameList[0]);

    // Exemplo de laço for tradicional com índice
    for (var i = 0; i < nameList.length; i++) {
      print(nameList[i]);
    }
    
    // Exemplo de laço for-in (mais simplificado)
    for (String name in nameList) {
      print(name);
    }

    for (int number in numberList) {
      print(number = 3);
    }

    void inprimirMap() {
      print(dadosDiego["nome"]);
      print(dadosDiego["idade"]);
    }

  }
}
