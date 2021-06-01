import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_convert/field.dart';
import 'package:my_convert/main.dart';

class Home extends StatefulWidget { //estado mutável
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realController = TextEditingController(); //controladores dos campos de textos
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar; // variavies obtidas da API, para conversão
  double euro;

  void _clearAll (){ // limpar campos de texto
    realController.text = "";
    euroController.text = "";
    dolarController.text = "";
  }

  void _realChanged(String text){ //converter real p euro e dolar

    if (text.isEmpty)
      _clearAll(); // limpa se estiver vazio

    double real = double.parse(text); //variavel do valor em reais que desejo converter
    dolarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }
  void _dolarChanged(String text){
    if (text.isEmpty)
      _clearAll();

    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = ((dolar * this.dolar)/euro).toStringAsFixed(2);
  }
  void _euroChanged(String text){

    if (text.isEmpty)
      _clearAll();

    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = ((euro * this.euro)/dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          "Conversor de Moedas",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      backgroundColor: Colors.purple,
      body: FutureBuilder<Map>(
        future: getData(), // futuro dos nossos dados
        builder: (context, snapshot) {
          //o que mostrar na tela em cada um dos casos
          switch (snapshot.connectionState) {
            case ConnectionState.none: // nao conectado ou esperando uma coneção
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white)
                )
              );
            default: //caso retorno alguma coisa, seja erro ou não
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar os dados",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {

                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox (height: 50),
                      Icon(Icons.monetization_on, size: 150, color: Colors.white,),
                      SizedBox (height: 50),
                      DecorBorder("Dólar", text: "US\$", controller: dolarController, changed: _dolarChanged,),
                      SizedBox (height: 20),
                      DecorBorder("Euro", text: "€", controller: euroController, changed:_euroChanged,),
                      SizedBox (height: 20),
                      DecorBorder("Real", text: "R\$", controller: realController, changed: _realChanged,),
                      SizedBox (height: 20),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
