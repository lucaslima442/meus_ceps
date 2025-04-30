import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meus_ceps/repositorios/viacep_repositorio.dart';

import '../modelos/cep.dart';
import '../repositorios/back4app_repositorio.dart';
import 'lista_ceps.dart';

class ConsultarCep extends StatefulWidget {
  const ConsultarCep({super.key});

  @override
  State<ConsultarCep> createState() => _ConsultarCepState();
}

class _ConsultarCepState extends State<ConsultarCep> {

  late Back4AppRepositorio back4appRepositorio;
  late ViaCEPRepositorio viaCEPRepositorio;
  List<Cep>? listaDeCeps;
  Cep? cep;
  bool isLoad = false;
  bool isUp = false;


  buscarCep() async {
    listaDeCeps = (await back4appRepositorio.listarCEPS())?.map((e) => Cep.fromJson(e)).toList();
    setState(() {});
  }

  Future<void> pesquisarCep(String cep) async {
    Map<String, dynamic>? response = await viaCEPRepositorio.buscarCEP(cep);
    if(response != null) this.cep = Cep.fromJson(response);
    setState(() {});
  }

  Future<void> adicionarCep(Cep? cep) async {
    if(isLoad == false && cep!=null) {
      isUp = true;
      if(await back4appRepositorio.enviarCEP(cep.toJson())) (listaDeCeps??=[cep]).add(cep);
      isUp = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    back4appRepositorio = Back4AppRepositorio();
    viaCEPRepositorio = ViaCEPRepositorio();
    super.initState();
    buscarCep();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Consultar CEP'),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListaCEPS()));
              },
              child: Row(
                children: [
                  Icon(Icons.list),
                  SizedBox(width: 8,),
                  Text('Lista de Ceps')
                ],
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLength: 8,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (valor) async {
                          if(valor.length == 8) {
                            setState(() {
                              cep = null;
                              isLoad = true;
                            });
                            await pesquisarCep(valor);
                            isLoad = false;
                          } else {
                            setState(() {
                              cep = null;
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: cep!=null? cep?.cep != null? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CEP: ${cep?.cep}'),
                                Text('Logradouro: ${cep?.logradouro}'),
                              ],
                            )
                          ),
                          listaDeCeps?.any((e) => e.cep?.trim() == cep?.cep?.trim())??false?
                              const SizedBox(): ElevatedButton(
                            onPressed: () async {
                                await adicionarCep(cep);
                            },
                            child: const Text('Adicionar a Lista'),
                          )
                        ],
                      ),
                      Text('Complemento: ${cep?.complemento}'),
                      Text('Bairro: ${cep?.bairro}'),
                      Text('Localidade: ${cep?.localidade}'),
                      Text('UF: ${cep?.uf}'),
                      Text('Estado: ${cep?.estado}'),
                      Text('Região: ${cep?.regiao}'),
                      Text('IBGE: ${cep?.ibge}'),
                      Text('GIA: ${cep?.gia}'),
                      Text('DDD: ${cep?.ddd}'),
                      Text('SIAFI: ${cep?.siafi}'),
                    ],
                  ) : Text('Cep não encontrado') : isLoad? IntrinsicHeight(child: Center(child: SizedBox(width: 200, height: 3, child: LinearProgressIndicator()))) : Text('Cep não encontrado') ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}