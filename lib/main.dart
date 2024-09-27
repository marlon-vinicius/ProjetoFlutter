import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: Scaffold(
          body: Dashboard(),
        ),
      ),
    );

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerCampoNumeroConta = TextEditingController();
  final TextEditingController _controllerCampoValor = TextEditingController();

  FormularioTransferencia({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //cololocar cor no texto Transferência
        title: const Text(
          "Criando transferência",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body:  Column(
        children: [
          Editor(controlador: _controllerCampoNumeroConta, rotulo: 'Numero da conta', dica: '0000'),
          Editor(controlador: _controllerCampoValor, rotulo: 'Valor',dica: '0.00',icone: Icons.monetization_on),
          
          ElevatedButton(
          onPressed: (){ 
            _criarTransferencia(
              context,
              _controllerCampoNumeroConta,
              _controllerCampoValor);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blue)
          ),
          child: const Text('Confirmar', style: TextStyle(color: Colors.white,fontSize: 18),
          )
          )
        ],
      )
    );
  }
  
  void _criarTransferencia(BuildContext context,controllerCampoNumeroConta, controllerCampoValor) {
    debugPrint("Clicou em confirmar");
    final int? numeroConta = int.tryParse(_controllerCampoNumeroConta.text);
    final double? valor = double.tryParse(_controllerCampoValor.text);
    if(numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {

  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  const Editor({super.key, this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controlador ,
              style: const TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                icon:  icone != null ? Icon(icone, color: Colors.green) : null,
                labelText: rotulo,
                hintText: dica
              ),
              keyboardType: TextInputType.number,
            ),
          );
  }
}

class ListaTransferencia extends StatefulWidget {
  
  final List<Transferencia> _transferencias = []; 
  
  @override
  State<StatefulWidget> createState() {
   return ListaTransferenciasState();
  }  
}

class ListaTransferenciasState extends State<ListaTransferencia> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //colocar cor no texto Transferência
        title: const Text(
          "Transferência",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, indice) {
            final transferencia = widget._transferencias[indice];
            return ItemTransferencia(transferencia);
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            debugPrint('chegou no then do future');
            debugPrint('$transferenciaRecebida');
            setState(() {
               widget._transferencias.add(transferenciaRecebida!);
            });           
          });

        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on, color: Colors.green),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor; //
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferência{valor: $valor, numeroConta: $numeroConta}';
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
     
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Dashboard",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          scrollDirection: Axis.horizontal,
          crossAxisCount: 2,
          children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: const Text("He'd have you all unravel at the"),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[200],
            child: const Text('Heed not the rabble'),
          ),
        ],
        )
      );
    }
}


