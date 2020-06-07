import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:themechanger/utils/customException.dart';
import 'package:themechanger/utils/constants.dart';

class APIProvider {
  final String _apiBaseUrl = TMDB_API_BASE_URL;

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_apiBaseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw InvalidInputException(response.body.toString());
      default:
        throw FetchDataException(
            'Error while communicating with server with status code : ${response.statusCode}');
    }
  }
}
