import 'dart:io';

import 'package:acaidajuh/models/cepaberto_address.dart';
import 'package:dio/dio.dart';

const token = '55e55a950e13d644cf26aefd3fac58d2';

class CepAbertoService {
  Future<CepAbertoAddress> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('.', '');
    final endPoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final response = await dio.get<Map<String, dynamic>>(endPoint);
      if (response.data.isEmpty) {
        return Future.error('CEP Inválido');
      }

      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);
      return address;

      print(response.data['cidade']['nome']);
    } on DioError catch (e) {
      return Future.error('Erro ao buscar CEP');
    }
  }
}
