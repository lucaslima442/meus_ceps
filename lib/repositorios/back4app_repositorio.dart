import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:dio/dio.dart';

class Back4AppRepositorio {

  late Dio dio;

  Back4AppRepositorio(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://parseapi.back4app.com/classes/ceps',
        responseType: ResponseType.json,
        headers: {
          'X-Parse-Application-Id': dotenv.env['BACK4APP_APPLICATION_ID'].toString(),
          'X-Parse-REST-API-Key': dotenv.env['BACK4APP_REST_API_KEY'].toString(),
          'content-type': 'application/json'
        }
      ),
    );
  }

  Future<bool> enviarCEP(Map<String, dynamic> data) async {
    try {
      Response response = await dio.post('', data: data);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Erro ao enviar CEP: $error');
    }


  }

  Future<Map<String, dynamic>?> buscarCEP(String cep) async {
    try {
      Response response  = await dio.get('/$cep');
      if (response.statusCode == 200) {
        return response.data is Map? (response.data as Map).cast<String, dynamic>() : jsonDecode(response.data) as Map<String, dynamic>;
      } else {
        throw Exception('Erro ao buscar CEP');
      }
    } catch (e) {
      return null;
    }
  }


  Future<List<Map<String, dynamic>>?> listarCEPS() async {
    try {
      Response response  = await dio.get('');
      if (response.statusCode == 200) {
        return (response.data['results'] as List?)?.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Erro ao buscar CEP');
      }
    } catch (e) {
      throw Exception('Erro ao buscar CEP: $e');
    }
  }
}