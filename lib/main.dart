import 'dart:developer';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const Scaffold(
          body: Dashboard(),
          backgroundColor: Colors.lightGreen,
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
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.greenAccent,
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
            backgroundColor: WidgetStateProperty.all(Colors.green)
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

class FormularioContato extends StatelessWidget {
  final TextEditingController _controllerCampoNome = TextEditingController();
  final TextEditingController _controllerCampoEndereco = TextEditingController();
  final TextEditingController _controllerCampoTelefone = TextEditingController();
  final TextEditingController _controllerCampoEmail = TextEditingController();
  final TextEditingController _controllerCampoCpf = TextEditingController();

  FormularioContato({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastro de Clientes",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.greenAccent,
      ),
      resizeToAvoidBottomInset: true,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
            Column(
            children: [
              EditorContatos(controlador: _controllerCampoNome, rotulo: 'Nome', dica: 'José da Silva'),
              EditorContatos(controlador: _controllerCampoEndereco, rotulo: 'Endereço',dica: 'Rua A'),
              EditorContatos(controlador: _controllerCampoTelefone, rotulo: 'Telefone',dica: '(16)98765-4321'),
              EditorContatos(controlador: _controllerCampoEmail, rotulo: 'E-mail',dica: 'email@gmail.com'),
              EditorContatos(controlador: _controllerCampoCpf, rotulo: 'CPF',dica: '987.654.321-00'),
              
              ElevatedButton(
              onPressed: (){ 
                _criarContato(
                  context,
                  _controllerCampoNome,
                  _controllerCampoEndereco,
                  _controllerCampoTelefone,
                  _controllerCampoEmail,
                  _controllerCampoCpf);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green)
              ),
              child: const Text('Confirmar', style: TextStyle(color: Colors.white,fontSize: 18),
              )
              )
            ],
          )
        )
      )
    );
  }

  void _criarContato(BuildContext context,controllerCampoNome, controllerCampoEndereco, controllerCampoTelefone, controllerCampoEmail, controllerCampoCpf) {
    debugPrint("Clicou em confirmar");
    final String? nome = _controllerCampoNome.text;
    final String? endereco = _controllerCampoEndereco.text;
    final String? telefone = _controllerCampoTelefone.text;
    final String? email = _controllerCampoEmail.text;
    final String? cpf = _controllerCampoCpf.text;
    if(nome != null && endereco != null && telefone != null && email != null && cpf != null) {
      final contatoCriado = Contato(nome, endereco, telefone, email, cpf);
      debugPrint('$contatoCriado');
      Navigator.pop(context, contatoCriado);
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

class EditorContatos extends StatelessWidget {

  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;

  const EditorContatos({super.key, this.controlador, this.rotulo, this.dica});

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controlador ,
              style: const TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                labelText: rotulo,
                hintText: dica,
                hintStyle: const TextStyle(fontSize: 12.0),
                labelStyle: const TextStyle(color:  Color.fromARGB(255, 0, 133, 4),fontSize: 15.0),
              ),
              keyboardType: TextInputType.text,
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

class ListaContatos extends StatefulWidget {
  
  final List<Contato> _contatos = []; 
  
  @override
  State<StatefulWidget> createState() {
   return ListaContatosState();
  }  
}

class ListaTransferenciasState extends State<ListaTransferencia> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transferência",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.greenAccent,
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
        backgroundColor: Colors.greenAccent,
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ListaContatosState extends State<ListaContatos> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lista de Contatos",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView.builder(
          itemCount: widget._contatos.length,
          itemBuilder: (context, indice) {
            final contato = widget._contatos[indice];
            return ItemContato(contato);
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Contato?> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioContato();
          }));
          future.then((contatoRecebido) {
            debugPrint('$contatoRecebido');
            setState(() {
               widget._contatos.add(contatoRecebido!);
            });           
          });

        },
        backgroundColor: Colors.greenAccent,
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.black,
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
    final NumberFormat formatarNumero = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on, color: Colors.green),
        title: Text(formatarNumero.format(_transferencia.valor)),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class ItemContato extends StatelessWidget {
  final Contato _contato;

  const ItemContato(this._contato, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        
        leading: const Icon(Icons.person, color: Colors.black),
        title: Text('Nome: ${_contato.nome.toString()}', style: const TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text('Endereço: ${_contato.endereco.toString()}\nTelefone: ${_contato.telefone.toString()}\nE-mail: ${_contato.email.toString()}\nCPF: ${_contato.cpf.toString()}'),        
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferência{valor: $valor, numeroConta: $numeroConta}';
  }
}

class Contato {
  final String nome;
  final String endereco;
  final String telefone;
  final String email;
  final String cpf;

  Contato(this.nome,this.endereco, this.telefone,this.email,this.cpf);

  @override
  String toString() {
    return 'Contato{nome: $nome, endereço: $endereco, telefone: $telefone, email: $email, CPF: $cpf}';
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
            style: TextStyle(color: Colors.black,),
          ),
          backgroundColor: Colors.greenAccent,
        ),
        body: Column(
          children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            width: 150,
            height: 100,
            color: Colors.teal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  child: const Icon(Icons.group, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListaContatos()),
                    );
                  },
                ),
                  const Text("Contatos")
              ], 
            ) ,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            width: 150,
            height: 100,
            color: Colors.teal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 TextButton(
                  child: const Icon(Icons.monetization_on, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListaTransferencia()),
                    );
                  },
                ),
                  const Text("Transferências")
              ], 
            ) ,
          ),
        ],
        )
      );
    }
}


