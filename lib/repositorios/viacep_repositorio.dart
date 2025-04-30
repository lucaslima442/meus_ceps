import 'dart:convert';

import 'package:dio/dio.dart';

class ViaCEPRepositorio {

  late Dio dio;

  ViaCEPRepositorio(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://viacep.com.br/ws/',
        responseType: ResponseType.json,
      ),
    );
  }

  Future<Map<String, dynamic>?> buscarCEP(String cep) async {
    try {
      Response response  = await dio.get('https://viacep.com.br/ws/$cep/json/');
      if (response.statusCode == 200) {
        return response.data is Map? (response.data as Map).cast<String, dynamic>() : jsonDecode(response.data) as Map<String, dynamic>;
      } else {
        throw Exception('Erro ao buscar CEP');
      }
    } catch (e) {
      return null;
    }
  }
}