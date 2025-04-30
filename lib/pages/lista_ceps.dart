import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meus_ceps/pages/ceps_detalhes.dart';
import 'package:meus_ceps/repositorios/back4app_repositorio.dart';

import '../modelos/cep.dart';

class ListaCEPS extends StatefulWidget {
  const ListaCEPS({super.key});

  @override
  State<ListaCEPS> createState() => _ListaCEPSState();
}

class _ListaCEPSState extends State<ListaCEPS> {

  late Back4AppRepositorio back4appRepositorio;

  List<Cep> ceps = [];


  initPage() async {
    ceps = (await back4appRepositorio.listarCEPS())?.map((e) => Cep.fromJson(e)).toList()??[];
    setState(() {});
  }

  @override
  void initState() {
    back4appRepositorio = Back4AppRepositorio();
    super.initState();
    initPage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Ceps'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                initPage();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.separated(
            itemCount: ceps.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ceps[index].cep??'-'),
                subtitle: Text(ceps[index].logradouro??'-'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetalhesCeps(ceps[index])));
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: Colors.black12,),
          ),
        )
      ),
    );
  }
}