import 'package:flutter/material.dart';

import '../modelos/cep.dart';

class DetalhesCeps extends StatefulWidget {
  const DetalhesCeps(this.cep, {Key? key}) : super(key: key);

  final Cep cep;

  @override
  State<DetalhesCeps> createState() => _DetalhesCepsState();
}

class _DetalhesCepsState extends State<DetalhesCeps> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do CEP ${widget.cep.cep}'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: const Text('Logradouro'),
              subtitle: Text(widget.cep.logradouro??'-'),
            ),
            ListTile(
              title: const Text('Complemento'),
              subtitle: Text(widget.cep.complemento??'-'),
            ),
            ListTile(
              title: const Text('Bairro'),
              subtitle: Text(widget.cep.bairro??'-'),
            ),
            ListTile(
              title: const Text('Localidade'),
              subtitle: Text(widget.cep.localidade??'-'),
            ),
            ListTile(
              title: const Text('UF'),
              subtitle: Text(widget.cep.uf??'-'),
            ),
            ListTile(
              title: const Text('Estado'),
              subtitle: Text(widget.cep.estado??'-'),
            ),
            ListTile(
              title: const Text('DDD'),
              subtitle: Text(widget.cep.ddd??'-'),
            ),
            ListTile(
              title: const Text('Siafi'),
              subtitle: Text(widget.cep.siafi??'-'),
            ),
            ListTile(
              title: const Text('IBGE'),
              subtitle: Text(widget.cep.ibge??'-'),
            ),
            ListTile(
              title: const Text('GIA'),
              subtitle: Text(widget.cep.gia??'-'),
            ),
            ListTile(
              title: const Text('Região'),
              subtitle: Text(widget.cep.regiao??'-'),
            ),
            ListTile(
              title: const Text('Unidade'),
              subtitle: Text(widget.cep.unidade??'-'),
            ),
          ],
        ),
      )
    );
  }
}