import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controllerAlcool = TextEditingController();
  final TextEditingController _controllerGasolina = TextEditingController();
  String _textoResultado = "";

  //calcula qual a melhor opção
  void _calcular() {
    double? precoAlcool = double.tryParse(
      _controllerAlcool.text.replaceAll(",", "."),
    );
    double? precoGasolina = double.tryParse(
      _controllerGasolina.text.replaceAll(",", "."),
    );

    if (precoAlcool == null ||
        precoGasolina == null ||
        precoAlcool <= 0 ||
        precoGasolina <= 0) {
      setState(() {
        _textoResultado =
            "Número inválido. Digite números maiores que 0 e utilizando (.)";
      });
    } else {
      /*
      Fórmula: Se o preço do álcool dividido pelo preço da gasolina for
      >= 0,7 é melhor abastecer com gasolina, senão é
      melhor abastecer com álcool.
       */
      setState(() {
        _textoResultado = (precoAlcool / precoGasolina) >= 0.7
            ? "Melhor abastecer com Gasolina"
            : "Melhor abastecer com Álcool";
      });
      _controllerGasolina.clear();
      _controllerAlcool.clear();
      FocusScope.of(context).unfocus(); //fecha o teclado
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alcool ou Gasolina?"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          //permitir scroll quando teclado abrir
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //imagem logo
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset("images/logo.png"),
              ),
              // frase qual melhor opçao
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Saiba qual a melhor opção para abastecimento do seu carro",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              //campo alcool
              TextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ), //abre o teclado já com ponto ou virgula disponivel
                decoration: const InputDecoration(
                  labelText: "Preço Alcool, ex: 1.59",
                ),
                style: const TextStyle(fontSize: 22),
                controller: _controllerAlcool,
              ),
              //campo gasolina
              TextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: "Preço Gasolina, ex: 3.59",
                ),
                style: const TextStyle(fontSize: 22),
                controller: _controllerGasolina,
              ),
              //botao calcular
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _calcular,
                  child: const Text("Calcular", style: TextStyle(fontSize: 20)),
                ),
              ),
              //resultado
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _textoResultado,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
